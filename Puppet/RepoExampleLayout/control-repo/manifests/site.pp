#Disable filebusket by default for all file resources
File { backup => false }


node default {
    #include any classes declared in hiera
    lookup('classes', {merge => unique}).include
}