Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7DC3B8D7B;
	Wed,  7 Oct 2026 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407051; cv=none; b=K9RGiD0dqny/41js9AliuO9dsoJASpfzek64TkUPLlOIyAEQTkNFCuRoKWHjQhfScU0G9WGnN9nLtgpXM1f+Sn1StHrnqIkfeVTzU2TQIm4WdHyalX7QYZk/AIrJn3STT5Z6Pj3R2oGouY5FOC5pKoIj9oO5eVu/eZ56EvDHbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407051; c=relaxed/simple;
	bh=Z1Bl2OHJNSWILDEkHE5LymTzzIcGpeTeeeuL3zkDolY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tti+xsbYHvDA655Q4Js6KxrufxN3InPDG5QzRL2egh9JGiTFIoxC8XDzXMlz5I5je5ylgfmPPxudWPzfb1dwJBPOSdAlxERWIag6qzxdiOmuwHci4BPd6FsDoA09Emj29gKTHulSG8jDl6d85TWiHYlIpOomrAri6PIfr3mJ0Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=le0tRfju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="le0tRfju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5581F0089C;
	Wed,  7 Oct 2026 21:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407049;
	bh=CqzpfhkzFjTdigES5c5QxM6R+iypMFs7n1ILt6v8tcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=le0tRfjuT+MIv9KlfZkZDnK6d9kI8VB7w67C5AhBgCGnlrZ6980mTUXLyL5ddrOYN
	 5u1TtuN3mGzhPVeDvKgutMFUTupcBXKZqRN51PbY4pXUsMDEFgjoTCG3woo/QvI63m
	 JorDNOWj2dJsKtjn8p5tU6gslGb7Gh1Pc/VxXU+uPDOyY4QV6DzSxxit3bbOrK5RSE
	 +w+E5/lKkI7BKtuIfWMVHJJNbk1+MisbszrCIs3g+I/nquAySIt7TM1/monOkqJN4U
	 DnPJ92pLhVnNhtLymd2IuHRZtQWr5P0VjwXRHEdlZVh49SrvVHI5b7xqK8H4mmBM4c
	 Sfg20fHodF6fA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 580E3CE1DC2; Wed,  7 Oct 2026 14:04:09 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zhouyi Zhou <zhouzhouyi@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 4/8] rcutorture: Fix kvm-again.sh re-run failure on ppc64
Date: Wed,  7 Oct 2026 14:04:04 -0700
Message-Id: <20261007210408.1983713-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <f9cb7abd-db60-43f6-9392-27fe29abb75b@paulmck-laptop>
References: <f9cb7abd-db60-43f6-9392-27fe29abb75b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

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
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-again.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index b5239b52cb5da..9060b3dc89262 100755
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
2.40.1

