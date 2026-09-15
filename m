Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23323AE707
	for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462807; cv=none; b=c7iGHELRki6YKMwUDO1srrM5bScJsRxJEmb1yB8cNtLcyVwOshyW/Kca11tPGpKbXda0F+Ngxygc0TcL1j88qd4pRLOsg44Zg8FD7ANNgdtbFVtFmQ/PC8uyGtg1fPcKGpxM3MZqSgkRRmXkYUI0JGJ8+KyP4675Q6vwpclsu7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462807; c=relaxed/simple;
	bh=Ma9vhHsFT3GKyy+r48cmE2rj/TqIbzPQu2RdVnWvcYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i/vS8VpYtPcVrha3nzrhb+VuS08O6+VyyK3aWbtOBlOFO3XBBXY7srMCp2cL5gQ2CWQW9cmLctHU7ZLMSeMjl8Louh91z3NxMj3J+zkWbrSA2cUQMb0/IE1qYHeuQVZigOtMb9aLPuEXakRcPaxfD7Pr4Q9bd89TuH/p5XUDJ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0JbWlCl; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0JbWlCl"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-86b90133ae8so2347555b3a.1
        for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 02:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789462805; x=1790067605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DATieKM+IrnhcJS92QKz+qmlrQJPe8M5vyN/L8cE7Fk=;
        b=D0JbWlClNDmDa011ZH0fFPk2HE9Kmr2i0nD5CzDQEXNQhcRYU2jmqvH2RCS3FFWBE7
         V5OhEA1f2ALmJecP9siepqnzquJi+THFsyPdZMYw9+4gFOOCixa1n4/Qb8tkoQJZPhJn
         jhKtSCs0sOUULU7LMXO+LaKwmBFKmKvDRwpm+xyG+YMRE3vznOdXoT7i0a/ZnVcJOss3
         vArLUNhMmSDu9416w3EwwzUmxsSOEV4iDERmfgCSobFMfpAWx8Jm3j61DALWyyg4pKPd
         MctkCE1Q6VddeBrWZPLW5BCrbD16E+kstlBjv6FvPbpgbLZYxmhSaaDaAAcVwFoSCwx8
         Genw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789462805; x=1790067605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DATieKM+IrnhcJS92QKz+qmlrQJPe8M5vyN/L8cE7Fk=;
        b=eWHgosNyshLu5CSNIg0sHxynZosf4V9qlv9te6zPD4+9z32VSq8xI2Gs1qLMy9PmfF
         D0FZtpmHXWLsHiPVlxhHnNb73+7AJyF+rZn41ssqXmg/mBO90f3XwkORYgoqlUgXetIz
         Hb16UpI7/gdCPI5ZqTvmmZx3dLNof+sQAbSDjQ+uPLzKevb6aPmK7Iyr962J+Lozy3/6
         fs6SX8aX4IKUkdY7yMDDraxvenIFGQjktou6pKBs4NIxoSvr55cBRhcXAqTYl9aN8Yfp
         qdRnkSpY9W/fwIYNFfYDAEdZDOhl1Cc/7dv6xvd2EE8rJccoiIASgXKj1kY0Eo6rha8/
         q1wg==
X-Forwarded-Encrypted: i=1; AKwUvBxkHGCRi9zQ8BN1DFWPSt9F8JgohM7i3z7LrHnlWRTm/ZA9J2zkuCAPyWRnnJyeAuHc9bo=@vger.kernel.org
X-Gm-Message-State: AFuF++n2K19wQNxuimgxBTZpikSld4exuVFkJLma/erMBUsf7ZJyTHQB
	DEiWQQZd3emk7DQqc7fZd6+lpvJkOD76RD6pRRUcyeUjpXxL3EST9fFt
X-Gm-Gg: AYBFou1Iw0lZ9zqYW/Q6Yc67TYpM4NzR2YJnbGvCog+CANZtkrrWZW+sFpQoanYONz+
	Iixetav5Hb1Lu7eYl9n336GxVHIbscPvFEwHNKUKJmuprB6wBAneSf6sjD0varhYBFuzPx5juWQ
	GEtfLYVSOWmz3Rxb8Aa+Ad8UfX+ffgOJb8zuauuSIIO1WT5Y9sT8YnBMEyfUjfACCtQL9UmpxlJ
	RJakTD2ReD/R0eu9mBAqDUOyka8CP9B2g1Id4tNp9OGLEwF69Bo03VllDq90Mh3kd1WjXPqVcVh
	T6kQgn7PMtbQMTMD2RRJ/jsV6N65EYr2JpGBXcL87Y8os8S7jYi12vStjDu/JVFNsBmdCAE9tMn
	xdf5i8Dcy/f7elUhnSQrcMmHSoUR1b+66e3PDsuCox+V0vQB2+ajVum/wX2Ditq2qFK09LGLmBQ
	5Z/oVQepQkVl9gl4VZDJ2dIWaqk0Dg/Fc5bel3sfoZEletJCbziku7TvlZH9e4nfP6XePsURBJz
	z8SKGw2+GtTe+R6P01q4ILQA9iStEHBvW25boC5f+A5ImQ=
X-Received: by 2002:a05:6a00:94c9:b0:848:2ab3:ddeb with SMTP id d2e1a72fcca58-86f858ed348mr12207289b3a.14.1789462804931;
        Tue, 15 Sep 2026 02:00:04 -0700 (PDT)
Received: from localhost.localdomain ([2605:bc80:3010:503:f816:3eff:fe99:6bb3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6550df9sm6124342a12.16.2026.09.15.02.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:00:04 -0700 (PDT)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: paulmck@kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lance@osuosl.org
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH v2] rcutorture: kvm-again.sh: Fix re-run failure on ppc64
Date: Tue, 15 Sep 2026 08:59:49 +0000
Message-Id: <20260915085949.3708122-1-zhouzhouyi@gmail.com>
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
Changes in v2:
 - Remove blank line between qemu_binary and boot_image assignments
   for cleaner style.

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
+	boot_image="`identify_boot_image "$qemu_binary"`"
+	kvm-transform.sh "$kernel_dir/`basename $boot_image`" "$qemu_cmd_dir/console.log" "$jitter_dir" "$dur" "$bootargs" < $T/qemu-cmd > $i
 	if test -n "$arg_remote"
 	then
 		echo "# TORTURE_KCONFIG_GDB_ARG=''" >> $i
--
2.43.0
