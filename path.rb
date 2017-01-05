module PATH

    def self.map(path)
        # mapping = MAPPING[path.join('/')]
        # mapping ? "#{mapping} (#{path[-1]})" : path[-1]
        path[-1]
    end


MAPPING = {
    'U16' => 'content -info',
    'U16/U6' => 'content-type',
    'U16/C0' => 'pkcs7-content',
    'U16/C0/U16' => 'signed-data',
    'U16/C0/U16/U2' => 'version',
    'U16/C0/U16/U17' => 'digest-algorithms',
    'U16/C0/U16/U17/U16' => 'algorithm-identifier',
    'U16/C0/U16/U16' => 'content-info',
    'U16/C0/U16/U16/U6' => 'content-type',
    'U16/C0/U16/U16/C0' => 'pkcs7-content',
    'U16/C0/U16/C0' => 'certificates',
    'U16/C0/U16/C0/U16' => 'certificate',
    'U16/C0/U16/C0/U16/U16' => 'signed',
    'U16/C0/U16/C0/U16/U16/C0' => 'version',
    'U16/C0/U16/C0/U16/U16/C0/U2' => 'version number',
    'U16/C0/U16/C0/U16/U16/U2' => 'serial number',
    'U16/C0/U16/C0/U16/U16/U16' => 'issuer',
    'U16/C0/U16/C0/U16/U16/U16/U17' => 'distinguished-name',
}



end