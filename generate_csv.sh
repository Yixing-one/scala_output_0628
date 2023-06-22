# Generate csv file summarizing the result of building community build with different option
#   (1) no_change: scalacOptions = List("-Xcheck-macros", "-Ysafe-init")
#   (2) explicit: scalacOptions = List("-Xcheck-macros", "-Ysafe-init", "-Yexplicit-nulls")
#   (3) explicit_unsafe: scalacOptions = List("-Xcheck-macros", "-Ysafe-init", "-Yexplicit-nulls", "-language:unsafeNulls")
#   (4) flexible: scalacOptions = List("-Xcheck-macros", "-Ysafe-init", "-Yexplicit-nulls", "-Yflexible-types")
#   (5) flexible_unsafe: scalacOptions = List("-Xcheck-macros", "-Ysafe-init", "-Yexplicit-nulls", "-language:unsafeNulls", "-Yflexible-types")

# Options that are tested
opt_list=(
        "no_change"
        #"explicit"
        #"explicit_unsafe"
        #"flexible"
        #"flexible_unsafe"
)

# Name of all community project that are built
project_list=(
        #testA
        "izumiReflect"
        "scalaSTM"
        "scalatest"
        "scalatestplusTestNG"
        "scissLucre"
        "zio"
        #testB
        "cats"
        "catsEffect3"
        "catsMtl"
        "coop"
        "discipline"
        "disciplineMunit"
        "disciplineSpecs2"
        "fs2"
        "monocle"
        "munit"
        "munitCatsEffect"
        "perspective"
        "scalacheckEffect"
        "scodec"
        "scodecBits"
        "simulacrumScalafixAnnotations"
        "spire"
        "http4s"
        #testC
        "akka"
        "betterfiles"
        "cask"
        "effpi"
        "endpoints4s"
        "fansi"
        "fastparse"
        "geny"
        "intent"
        "jacksonModuleScala"
        "libretto"
        "minitest"
        "onnxScala"
        "oslib"
        "parboiled2"
        "playJson"
        "pprint"
        "protoquill"
        "requests"
        "scalacheck"
        "scalaCollectionCompat"
        "scalaJava8Compat"
        "scalap"
        "scalaParallelCollections"
        "scalaParserCombinators"
        "scalaPB"
        "scalatestplusScalacheck"
        "scalaXml"
        "scalaz"
        "scas"
        "sconfig"
        "shapeless"
        "sourcecode"
        "specs2"
        "stdLib213"
        "ujson"
        "upickle"
        "utest"
        "verify"
        "xmlInterpolator"
        )

# Generate the header of CSV
rm opt_result_summary.csv
csv_line=""
csv_line+="Project Name,"
for opt in "${opt_list[@]}"; do
  csv_line+="$opt,"
done
echo "${csv_line}" >> opt_result_summary.csv


for project in "${project_list[@]}"
do
    csv_line=""
    csv_line+="\"$project\","
    for opt in "${opt_list[@]}"; do
        if grep -r "Total 1," "output_${opt}/${project}.log"; then
            if grep -r 'SUCCESS' "output_${opt}/${project}.log"; then
                csv_line+="SUCCESS,"
            elif  grep -r 'FAILURE' "output_${opt}/${project}.log"; then
                csv_line+="FAILURE," 
            else 
                csv_line+="ERROR," 
            fi
        else 
            csv_line+="NO_TEST_RUN," 
        fi
    done
    echo "${csv_line}" >> opt_result_summary.csv
done