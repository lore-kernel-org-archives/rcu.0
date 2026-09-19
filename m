Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674C1547078
	for <rcu@vger.kernel.org>; Sat, 19 Sep 2026 01:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779987; cv=none; b=T7DHJgm2jo1PE+gZukBgo5EYn7Hmy/0s1okc6KizBWklt42fhhti+kzngLsXZmDNPpMLIzeaybHHvVoYSN6Z39BtWAGjz26V31MAQsSvextbF4Y3hE2GlIIVD4OeC+dbigAE8KdG/xUCRiEtHdxAcB9aQxoue8/bjEdSVc2o7i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779987; c=relaxed/simple;
	bh=UgK6zDG18uoS3J6tXdJQ0E5iNtWkMbqUJLbK7n7U0Yg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fbft6V/bDRGmbEB/AS9nZMbxb09d3pKn8jYy45WQmlX/fQ+ZmBb1hOUVzaGblMwDW4F8mU8Gy9oq84Bl0Sf75Yd3DxHXE6g3/XQP+F4SyLgB9mydEAahYxTy7RBfM0zaAFY78zgqpN0DpWBEKHc/hwEBRpCffiJ1RokDHwrmuh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOzO7w+z; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOzO7w+z"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d90ba1d807so16443325ad.3
        for <rcu@vger.kernel.org>; Fri, 18 Sep 2026 18:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789779976; x=1790384776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6LTqB6a9B9UKh0x9TDelgFRYjmXFU1lhcgKSzwgGYlw=;
        b=IOzO7w+zMUQPuZ6R16Syig5vMisEhJB4FDEhV3jJh+WkZ2eob5m4pOMlWeLWBZ1aDx
         mQRSjzf/mLgOOLWtyXgMmS05xH1p99gXkESLbaupFnfGa+X7qhLNaRh5VbsbE0EzQ0ch
         YttZHvEeEVI8YyH4KTKuFMLXhqzH3C1UDwn8tn+SW5gkO/Em3+fR58QkNC6vqTkkS8X2
         9XL59bHcIoo8/uhzOXRDOjazj2vq+UzN+B2iCGQsMMEp+uw1+qY9Wkm3gocL7Y1D4L0C
         aNm7fJDzW08m6bJ50KfrUUf5bgSJLTPX1w+YtUh7aO2qegr7GpOgTRLY9nB9OcUqiXUb
         eJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789779976; x=1790384776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6LTqB6a9B9UKh0x9TDelgFRYjmXFU1lhcgKSzwgGYlw=;
        b=QUSqz20GvzLXqfstMJtIzPrQGWMsyRK1CMn4a2EyLekOw4icNbH5F5hY1MrPRcvsnS
         aX9yHqTzQiNPhkKOEIQI3dCcoPHeUqe8pBXRokq4mVwwHaP1eIR1Ta2J9qRLkDp//Qqp
         aO80efKP0WWtLlDDGgWXt9E/2Wp4D0KytTAkMQKPHhjsw5FBdcABihwhF82HvYOj5oGB
         xOcZsAEHa7gbieOYictPsrdgS6k17t3htdAUh8o0Q2LXC0sBWMcCgr8Y7VsCgvOkk1h2
         iYciK4mAH0bCq4mFyil5I9DTbH/t1ppjvekVccnYaySzRfYBu8PZWh6YrXc44ikl+pHq
         1SFg==
X-Forwarded-Encrypted: i=1; AKwUvByOF5wNlt56dFdRS53GaOTD3WJ7bUyqknpXKHLmdk2MooXzMWlEERt5OALVIXf0DlJ3Z5E=@vger.kernel.org
X-Gm-Message-State: AFuF++klvMy81S5UP2fG3+G3ogF97P36Fmi6A2WTL/lNigcg1L5pDzqc
	wb99DIWrom2A2uqYPEw0hwpGuB4pBnTuXL32ZXhUZVtI1sTKeF/NpMLV
X-Gm-Gg: AYBFou2Fc43SwgwbuxFCPHrDc21Mo6M3OT+ari7lOUWWKhPIu1NXZEPc3I/HI9ceE54
	sa7xlCfYJJOG1ekx2H/s8TCm+LwIDMmsJDL2KTGTGmjXoq8hGu2BMbZJ+bnmozlGR4ILvtvf2OX
	53v5sifm7ID1bKVdiAa/MPk8gEfYsULqa36gHDJd2M8ciCPFcFOCT6s+11QQVpLOYIjuuDMbOYX
	HaqH5TQoGKe2o7lVd1wnun9jsUMATrTVOyLLVLtFGFxerhCgjJH+0JXh2WQXLP1xI/gEp3BDH2h
	VpqNeM/DguLX/knM1rAK8v6/a/G0B0SHs2h+bLTHNdgFsgAy0bVQUMpuhEigdUjWfypNYMvstbN
	9Mvx+a3htHcCbbnocLGDkc5NalbMjE1seieEEcEcE4UnmQluJi1dK98MuYGdYQkab0hVsIwzpYG
	Zmr6lmUfsrdIC9iV1fzij8Y1fF7QGwkp9yxIxzRqywigiGZeCJ6WT3katYo7fuTFa9bt17kl/eg
	nMfpq1ImGyC0HDEfkPtdmDGqMn3B7cgsQomVLbOHylpYVA=
X-Received: by 2002:a17:903:2acc:b0:2dd:c132:dc27 with SMTP id d9443c01a7336-2ddc132dc8bmr18159265ad.47.1789779975721;
        Fri, 18 Sep 2026 18:06:15 -0700 (PDT)
Received: from localhost.localdomain ([2605:bc80:3010:503:f816:3eff:fe99:6bb3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df3140fd2fsm1651805ad.61.2026.09.18.18.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 18:06:15 -0700 (PDT)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: paulmck@kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lance@osuosl.org
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH v3] rcutorture: kvm-again.sh: Fix re-run failure on ppc64
Date: Sat, 19 Sep 2026 01:06:06 +0000
Message-Id: <20260919010606.2916865-1-zhouzhouyi@gmail.com>
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
   the re-run on that architecture.  Drop vmlinux from the unconditional
   list, and instead conditionally delete it only when the boot image
   basename is not vmlinux.

In addition, identify qemu_binary before the copy step so that on
non-PowerPC systems (where vmlinux is not the boot image) the vmlinux
file can be removed immediately after the run directory is copied,
saving storage before any tests run.  This also eliminates the
per-iteration re-computation of qemu_binary and boot_image inside
the qemu-cmd transform loop.

Tested on a local x86_64 machine and on a PPC VM of the Open Source Lab
of Oregon State University.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
Changes in v3:
 - Identify qemu_binary and boot_image earlier, before the copy step,
   so that vmlinux can be removed right after copying the run directory
   on non-PowerPC systems, saving storage.  This also eliminates the
   per-iteration re-computation of qemu_binary and boot_image inside
   the qemu-cmd transform loop.
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-again.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index b5239b52cb5d..9060b3dc8926 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -180,6 +180,9 @@ fi
 
 echo ---- Re-run results directory: $rundir
 
+qemu_binary="$(find "$oldrun" -maxdepth 2 -name 'qemu-cmd' -type f 2>/dev/null | head -1 | xargs -r grep -v '^#' 2>/dev/null | awk 'NF { print $1; exit }')"
+boot_image="`identify_boot_image "$qemu_binary"`"
+
 if test "$oldrun" != "$rundir"
 then
 	# Copy old run directory tree over and adjust.
@@ -189,7 +192,7 @@ then
 		echo "Cannot copy from $oldrun to $rundir."
 		usage
 	fi
-	rm -f "$rundir"/*/{console.log,console.log.diags,qemu_pid,qemu-pid,qemu-retval,Warnings,kvm-test-1-run.sh.out,kvm-test-1-run-qemu.sh.out,vmlinux} "$rundir"/log
+	rm -f "$rundir"/*/{console.log,console.log.diags,qemu_pid,qemu-pid,qemu-retval,Warnings,kvm-test-1-run.sh.out,kvm-test-1-run-qemu.sh.out} "$rundir"/log
 	touch "$rundir/log"
 	echo $scriptname $args | tee -a "$rundir/log"
 	echo $oldrun > "$rundir/re-run"
@@ -197,6 +200,10 @@ then
 	then
 		$arg_link "$oldrun/../../bin" "$rundir/../.."
 	fi
+	if test "`basename "$boot_image"`" != vmlinux
+	then
+		rm -f "$rundir"/*/vmlinux
+	fi
 else
 	# Check for a run having already happened.
 	find "$rundir" -name console.log -print > $T/oldrun-console.log
@@ -217,7 +224,7 @@ do
 	qemu_cmd_dir="`dirname "$i"`"
 	kernel_dir="`echo $qemu_cmd_dir | sed -e 's/\.[0-9]\+$//'`"
 	jitter_dir="`dirname "$kernel_dir"`"
-	kvm-transform.sh "$kernel_dir/bzImage" "$qemu_cmd_dir/console.log" "$jitter_dir" "$dur" "$bootargs" < $T/qemu-cmd > $i
+	kvm-transform.sh "$kernel_dir/`basename $boot_image`" "$qemu_cmd_dir/console.log" "$jitter_dir" "$dur" "$bootargs" < $T/qemu-cmd > $i
 	if test -n "$arg_remote"
 	then
 		echo "# TORTURE_KCONFIG_GDB_ARG=''" >> $i
-- 
2.43.0

