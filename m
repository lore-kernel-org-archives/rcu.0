Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2224756A3
	for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461936; cv=none; b=ub6nQb4QOyKX4GWiC4+QSdY+lMvGhbZowKGbFaecvKoDcLRHsMDD4jpPgABRZnkfsH0FMzLv5AYa/qw4ks+Slsi+EMuQBd0n3jMin/3R6eqNHZ06iIqJpIt25AbvCSUM0A+IXYLwk1+Hnv/wqGZLTlVJFDIYmm+eoJaI8Y03SsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461936; c=relaxed/simple;
	bh=pBVQUYDEIa449zGkcGqUxCzep0SQppBBLbV02Ru7awY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JY+YlrIrBDwU3ipIUpyN7tGIHg9d/PX7zruwHMDyr7eEXwq4+SL/N14DWzARJLC9p7zvHkVuF9i2R/9WW4hQndEBULkyKG2jdc+c/t3YS6HcOnRKdd/PCcQtBKK+mNZ0PPHqeaMwVYZJCl6Iqwerck7x4uGh95fh1CGMcZ8P7z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iK82ENZw; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK82ENZw"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e25400so2334257b3a.0
        for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 01:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789461934; x=1790066734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+zi0InBQk+d9zqvUf20Lgt1upBg3iykRVf2Yi8TjmXE=;
        b=iK82ENZw3HG1bf7WPkGF1tVcn1yqqCAjazQmDOUhF+1SIeVrlaBY+JrbHIoHqRFPzq
         C3gZkWINHxp++mqMyztuZmUAu63fS/eHQ175bTKZGshhy6FvEJ4mmTYyMvb586oORSZl
         OrCfZ3d5ekfatIeQfLrqpdy/KeDBss+vlvsNOdjyF6dVVHd7VaWJl4e4qjyJotIEsT/E
         84142cLZCsSft4F6nEjUliDQ6S9qwwbsp8vzBFFH6SzbJ8BaPBTdfLrnwPrchyAdGKPe
         GOPHHuwD7tCeIqXUNG0jSc32Huk8PqFP9P6Hh/r6DfOMYD2vX9R7GB/sgfYXOiXniO2c
         5OLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789461934; x=1790066734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+zi0InBQk+d9zqvUf20Lgt1upBg3iykRVf2Yi8TjmXE=;
        b=A1+5GaIeSyWX7zxh2tkLnq4HItJVnFI2OD+GNJLe48HYnkQEHeKjyaHsezuVH5fIf9
         EcU+FTJTXjVC2up/nVvHrXibFtcGhQFIFIVxvgzM4tcPtzfF103jBXyvr3gskv5H+ekP
         MfDtwVaBcYQXeVuVz0scsAhlXtTzV7GBKkQIgs2MUNtBJ44YJH6L5CWmTd00swe6HbTP
         4ninvhEHE9dHXK9upCkwhbg/C9MNLzfFwTgJuBv16Hnsebqy+u9LSXV2xChKaDbG5bOh
         ATqcPIqVOvJ11s6szNveRKpNJLB6eDY5I7Fja7mWWYVXUrtvE2puWewKiE7ygcmRmdu6
         DhOw==
X-Forwarded-Encrypted: i=1; AKwUvBxEXqes57KwOJb+pJbjVIXCaty6kCZPdZzMEEcGm9BSYKBeia7hVsy4JSynmsGiKSVw19c=@vger.kernel.org
X-Gm-Message-State: AFuF++nKt6geG4swBG5B3qKKj0PC7FukBFHOTwbIXHlFbWm/G+OOgrzC
	/3NVo3q9JIGMTSfEnM5bQXv1zO5LfDEizrPg62IVsywGPmWGwxJynXx5
X-Gm-Gg: AYBFou3yhP3lMcykaF85cEMwblxM8ojiHNSESR3m7BqhEfWlnKd+yWOqUgtMftbNqAL
	XGIe1NW3jow+pg48gzP2U7FcvqN4mtwRMExLtJrQCVYaYwTloAnN2X4+D2wAZZfzkOKyioxsGPZ
	CVZFk6ppmg6UMBQcF2SISeEhpPCUTiB+z9+4zRo3KVT3ZewYszpblNh19sn8XsOboH48B91oEkm
	kh1js3p6U7SpdN4Mr+I2AZ/Ln+zPvefbUPz+fGh+PRKParKF0WwYLkI7IYPljtDoGMnEvH/0meE
	CP6oHe57iDOi7vDkoKxROTs0rIw+Kl/eWAXCn+GT05nScVdmTZKTET/FNuo8ObyKO9uCK5QiGXn
	OIrBIBHQpyb2bjMXvpuG4l/ZRHf3VQ6X/2JdASR+LTRghiUhCxXAFn3gR6AmCkSZhdEEOvQyWkD
	q9xldyH6ktOB/GLOJ+oEhFqhqZ8VJFisP+HJxKnQ3mMTS6U5T1WH+QOYf8KeNgZzOVi/VNfrtFA
	jasA51mmkMxbJnoalC80/Z3GkMTeWOB0Hn8Z+P9kkNJFqU=
X-Received: by 2002:a05:6a00:3e0c:b0:86a:881e:ea38 with SMTP id d2e1a72fcca58-86f858ee0f6mr16380664b3a.12.1789461934301;
        Tue, 15 Sep 2026 01:45:34 -0700 (PDT)
Received: from localhost.localdomain ([2605:bc80:3010:503:f816:3eff:fe99:6bb3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b292bd2fcsm5752803b3a.30.2026.09.15.01.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:45:33 -0700 (PDT)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: paulmck@kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lance@osuosl.org
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] rcutorture: kvm-again.sh: Fix re-run failure on ppc64
Date: Tue, 15 Sep 2026 08:45:28 +0000
Message-Id: <20260915084528.3707627-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Discovered in the Open Source Lab of Oregon State University when running
torture.sh on a ppc64le VM.  Two bugs were exposed:

1. The kvm-transform.sh call hard-coded "bzImage" as the kernel image
   name.  On ppc64, the boot image is vmlinux, not bzImage, so the
   re-run failed to find the image.  Fix this by extracting the QEMU
   binary from the qemu-cmd file and passing it to identify_boot_image()
   to obtain the correct architecture-specific image name, the same way
   kvm.sh already does.

2. The rm -f invocation on re-run listed vmlinux among the files to
   delete.  On ppc64 vmlinux is the boot image, so deleting it broke
   the re-run on that architecture.  Drop vmlinux from the list.

Tested on a local x86_64 machine and on a PPC VM of the Open Source Lab
of Oregon State University.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 tools/testing/selftests/rcutorture/bin/kvm-again.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index b5239b52cb5d..cacc9f2b230d 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -189,7 +189,7 @@ then
 		echo "Cannot copy from $oldrun to $rundir."
 		usage
 	fi
-	rm -f "$rundir"/*/{console.log,console.log.diags,qemu_pid,qemu-pid,qemu-retval,Warnings,kvm-test-1-run.sh.out,kvm-test-1-run-qemu.sh.out,vmlinux} "$rundir"/log
+	rm -f "$rundir"/*/{console.log,console.log.diags,qemu_pid,qemu-pid,qemu-retval,Warnings,kvm-test-1-run.sh.out,kvm-test-1-run-qemu.sh.out} "$rundir"/log
 	touch "$rundir/log"
 	echo $scriptname $args | tee -a "$rundir/log"
 	echo $oldrun > "$rundir/re-run"
@@ -217,7 +217,10 @@ do
 	qemu_cmd_dir="`dirname "$i"`"
 	kernel_dir="`echo $qemu_cmd_dir | sed -e 's/\.[0-9]\+$//'`"
 	jitter_dir="`dirname "$kernel_dir"`"
-	kvm-transform.sh "$kernel_dir/bzImage" "$qemu_cmd_dir/console.log" "$jitter_dir" "$dur" "$bootargs" < $T/qemu-cmd > $i
+	qemu_binary="`grep -v '^#' $T/qemu-cmd | awk 'NF { print $1; exit }'`"
+
+	boot_image="`identify_boot_image "$qemu_binary"`"
+	kvm-transform.sh "$kernel_dir/`basename $boot_image`" "$qemu_cmd_dir/console.log" "$jitter_dir" "$dur" "$bootargs" < $T/qemu-cmd > $i
 	if test -n "$arg_remote"
 	then
 		echo "# TORTURE_KCONFIG_GDB_ARG=''" >> $i
--
2.43.0
