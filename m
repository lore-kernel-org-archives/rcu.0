Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795883132;
	b=RQ5h21AhPu34okIbFz1MATGkMw2zZTW2rnCt5XMMi5kUShf5icQ0Ldf6Zpnv3HbcQ0lV
	 t7OvyxKxyfnVqVZXbrtVsEEXXrON8IUjxGvvKl8UY8k47oyZHcmGZcYhdjzKIvkiuwDk8
	 NurD6NkO2GrQTYoGljQVofaMOI1YOCxKrGN/7bfBtw3OW3IJrxrQ+LDFP4Qkg+mowbVHR
	 PfdN1rH9nmGvaUiBTGaX3+HL/5DqbQk+eqbrjAn8mVyKaCXilk30ZfXEYxyGgJJ7bOZ6Y
	 GIs8a0ujrn56t90MmqK2ZKIFFQ2dYonhR9+wKOpeEtfDNNIlzF18iN5XjZr0Ivy7Yew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795883132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=27dDFL7wVMW15bzHnm2/1q7smAv1Zk9BUXTu+eRE62g=;
	b=wL2+CYF+2iMUga6eZRXjXmJ3k1wtJ/y9q4AV4AOAKpyXMwNPy4l4NI0eBy5DOvJANl52
	 /y1aBdqadxnwJo3bmkNODZMh4BJJHCm5gDFU63n4mP0NuyuHjBxENSYLg7PO+kFaIxSUK
	 1ibqnU+P5nJ2J+N7DztZF4iGGC39fm0omi4LI/P8XKZl0TXFJGcjcCJUPYOK/lukUBFq0
	 abJEqmWHHVJ8LKLUJ5iXpUj8G/LzpUvu6TnW4zCAyYjpUkfsoR80P/r5Nb8DvFiohdUrf
	 rrYcruqYwzdJxTwoeV3H608w0FGOQNWTBMObXr7NRCJVw9xnxGbGSxjdMyAGmy3kCJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jFam3IHd;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8478E606A31C
	for <rcu@vger.kernel.org>; Sat, 28 Nov 2026 16:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8478E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jFam3IHd
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bba5e17cbeso35195255e9.1
        for <rcu@vger.kernel.org>; Sat, 28 Nov 2026 08:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795883131; x=1796487931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=27dDFL7wVMW15bzHnm2/1q7smAv1Zk9BUXTu+eRE62g=;
        b=jFam3IHd1+VDEwi4UaJqB3cdEMQKutn8JdiF9EAH+WeSISmmQdLI2oHWwBJA2k0ksg
         4t/GEWXbc7y8Fl+j3ZzI/VsuNlq/YMZZwJqb9VPKPnzZA+vp0DGGcxwDIJtceU2iEXsf
         ItzPfwo9jXH/G64TsJUUDzZGk0DKs+uZ+BKgu83LMWdKShDlB5G2xeDLhJ2LjfM5ZqSw
         0Qo1PDNLD9CjredoLz+PdkN4MW3Pj2mkl7bND0+1P+MIU7rpe1/I4eQzgRDKUjkooc5S
         bzSP13rXbcLIU+oAnSDer/zKSHJneL6epSJXkS/WTndvBtghxeo6WsQuOTOqZErrHPRa
         bjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795883131; x=1796487931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=27dDFL7wVMW15bzHnm2/1q7smAv1Zk9BUXTu+eRE62g=;
        b=wBbEwfSTQVtftSXTL76hG0h6LietHGApj0sqSyTHgJpgJS75NTbbxgpg2d8NN3jdgP
         OIfEH72sgD9CnLOrhMg1h1NKyqj1WkBSecal2c4YN/4mKo3jR2ajV0/3U+/bL2MRAJ7Q
         50itdImL22rTgmEO8TmZCGeEV/LAgJxVKjgxvgD6a5t+BVIQH0i4LhZsEsd/HfR6TGfR
         FFx8kw5MaLXyyK+PS652ELcqpM0ETbNTAfVUAoIlsC/wXpFajDq1LJOvv5VuOiGgzP7s
         DovUdGPvf2k4D536vd7nlQ2mg+a6IQ8WTpUAHfdPFo/4hSnwa5u7N5Dyg4AqAjcLQks4
         uZ9g==
X-Forwarded-Encrypted: i=1; AL+hErH+hVeq9GsqXohu+4by9yQcxlqOmV5BhdQyyaEcflvzVQ5C+Zq/pBCDcmOUgPIuWpHZokY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RGjYfm+E8s4fd6x/tjmwE6dy1SsqOyxyYYxDuuI3i6kzS/pq4
	JoZQahDERHaOc09Zuf8IBMDJCE76mCw5N488fO3THt6djkIKf4OnBUDS
X-Gm-Gg: AZFdTZcqa8LT2q1/Pz4ZNQ9e/LCvFnHPDLREra7rEhDzzvRQnz4Mzg4m1ydwnhSqiX1
	V0hdqcr0RO8TrWDWZtN68lUA5qg8oCo4M8PCxL6q9Dia4DyP6K2NI/AdSbIuVcGadbUu1rmIHuy
	DWVN3ZDdmOlJnGb38uZ0nF5loV2dy55NJEbV7hH8stJbbmM5CCbAU5c54y+oJonVESWRFzPfllj
	xMwuwQe1mWmSwsS+KDKwaFUFOa+84c075IssGuWTHgeiCEOdUrp/Guh/78rOruA6I8sVeZ1MS/F
	6TKBWWdVETSSd8a6ZKccW8URggdVgf+Zuol4VUyZAJs+1NzUxHt6S2WJLfkvkyLhr3yokNuOV6J
	+PuTTf9tLv5w9jgJL6s48eZW3b/xRe3LPxkfGqfnXl/Md1W2BkmyWVsde9Pima59qnZ9a9IdJU+
	48AYhB4vDUuBJ99xk2zB27ReSbe6PvBmLcozS4USN8thWdTgaLT8CJqXxGzaDr3wgZNvVpv9Nff
	Wwy3daVvvrs2KNSSQBtbVE7RRFyV6p7EAgFdVOc0+z3PnsagiB4iNHkuR+AxulCT2oaGXGCP8K5
	GtNJleDSXm2LgLsUoloLHnDw8jkQGdvW9G54OSzR2GBQ7fWkU7IozMRf2xAdf++z0IBKsV+86c3
	OdOuXp5+ptR7MoPh1iJ5WBvXdkF7GoxWBeMI1H9E=
X-Received: by 2002:a05:600c:310f:b0:4b5:d95c:2378 with SMTP id 5b1f17b1804b1-4bb8881f9b7mr599004195e9.34.1795883130105;
        Sat, 28 Nov 2026 08:25:30 -0800 (PST)
Received: from kernel.. ([191.40.25.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906d6a13sm456446595e9.3.2026.11.28.08.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:25:29 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	josh@joshtriplett.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH] rcutorture: Honor explicit QEMU CPU selection
Date: Sun, 29 Nov 2026 00:25:11 +0800
Message-ID: <20261128162511.3768408-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm-test-1-run.sh appends the default -cpu after the arguments from
--qemu-args. QEMU uses the last -cpu, so the default can override
an explicit selection such as -cpu host,pmu=on.

Emit the default -cpu before the user arguments and keep the other
arguments in their original order.

Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options")
Fixes: 67ad71ddbcae ("rcutorture: Add basic ARM64 support to run scripts")
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
All 17 shell tests passed. On x86 KVM with QEMU 8.2.2, QMP reported
kvm64 with pmu=false before the patch and host with pmu=true after
it. Both runs passed -cpu host,pmu=on and started paused (-S).

 .../rcutorture/bin/functions-test.sh          | 94 +++++++++++++++++++
 .../selftests/rcutorture/bin/functions.sh     | 20 ++--
 .../rcutorture/bin/kvm-test-1-run.sh          |  4 +-
 3 files changed, 108 insertions(+), 10 deletions(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/functions-test.sh

diff --git a/tools/testing/selftests/rcutorture/bin/functions-test.sh b/tools/testing/selftests/rcutorture/bin/functions-test.sh
new file mode 100755
index 0000000000000..92edbed889576
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/functions-test.sh
@@ -0,0 +1,94 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Check the order of arguments emitted by identify_qemu_args().
+# Usage: functions-test.sh [functions.sh]
+#
+# Author: Kunwu Chan <kunwu.chan@gmail.com>
+
+set -efu
+
+scriptdir="$(cd -- "$(dirname -- "$0")" && pwd)"
+. "${1:-$scriptdir/functions.sh}"
+
+TORTURE_QEMU_INTERACTIVE=
+TORTURE_QEMU_MAC=
+console=/tmp/functions-test-console.log
+serial="-serial file:$console"
+nchecks=0
+nerrors=0
+
+check_qemu_args () {
+	local label="$1"
+	local qemu="$2"
+	local expected="$3"
+	local args
+
+	shift 3
+	args=$(identify_qemu_args "$qemu" "$console" "$@")
+	# Normalize whitespace as when the harness writes qemu-cmd.
+	set -- $args
+	nchecks=$((nchecks + 1))
+	if test "$*" = "$expected"
+	then
+		echo "ok $nchecks - $label"
+	else
+		echo "not ok $nchecks - $label"
+		printf '# expected: %s\n# got:      %s\n' "$expected" "$*"
+		nerrors=$((nerrors + 1))
+	fi
+}
+
+for arch in x86_64 i386 aarch64
+do
+	case "$arch" in
+	x86_64)
+		cpu=kvm64
+		machine=q35,accel=kvm
+		;;
+	i386)
+		cpu=kvm32
+		machine=q35,accel=kvm
+		;;
+	aarch64)
+		cpu=host
+		machine=virt,gic-version=host
+		;;
+	esac
+	tail="-machine $machine $serial"
+	check_qemu_args "$arch default CPU" "qemu-system-$arch" "-cpu $cpu $tail"
+	args="-smp 4 -net none -nodefaults"
+	check_qemu_args "$arch unrelated options" \
+		"qemu-system-$arch" "-cpu $cpu $args $tail" "$args"
+	args="-smp 4 -cpu host,pmu=on -nodefaults"
+	check_qemu_args "$arch explicit CPU" \
+		"qemu-system-$arch" "-cpu $cpu $args $tail" "$args"
+done
+
+tail="-machine q35,accel=kvm $serial"
+check_qemu_args "CPU token as guest name" qemu-system-x86_64 \
+	"-cpu kvm64 -name -cpu $tail" "-name -cpu"
+check_qemu_args "guest name and tab-separated --cpu" qemu-system-x86_64 \
+	"-cpu kvm64 -name -cpu --cpu host,pmu=on $tail" $'-name -cpu\t--cpu\thost,pmu=on'
+args="-cpu host,pmu=off --cpu host,pmu=on"
+check_qemu_args "multiple explicit CPU options" qemu-system-x86_64 \
+	"-cpu kvm64 $args $tail" "$args"
+args="-machine q35,usb=off -serial none"
+check_qemu_args "machine and serial ordering" qemu-system-x86_64 \
+	"-cpu kvm64 $args $tail" "$args"
+check_qemu_args "custom QEMU command" /opt/qemu/bin/qemu-system-x86_64 \
+	"-name test $serial" "-name test"
+ppc="-M pseries -nodefaults -device spapr-vscsi"
+check_qemu_args "ppc64 defaults" qemu-system-ppc64 "$ppc $serial"
+
+TORTURE_QEMU_INTERACTIVE=1
+serial="-monitor stdio -serial pty -S"
+check_qemu_args "x86_64 interactive" qemu-system-x86_64 \
+	"-cpu kvm64 -cpu host,pmu=on -machine q35,accel=kvm $serial" "-cpu host,pmu=on"
+TORTURE_QEMU_MAC=02:00:00:00:00:01
+ppc="$ppc -device spapr-vlan,netdev=net0,mac=$TORTURE_QEMU_MAC"
+check_qemu_args "ppc64 interactive with MAC" qemu-system-ppc64 \
+	"$ppc -netdev bridge,br=br0,id=net0 $serial"
+
+echo "1..$nchecks"
+test "$nerrors" -eq 0
diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 6e415ddb206f3..7fa760073fb30 100755
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -227,27 +227,31 @@ identify_qemu_append () {
 	fi
 }
 
-# identify_qemu_args qemu-cmd serial-file
+# identify_qemu_args qemu-cmd serial-file [qemu-args]
 #
-# Output arguments for qemu arguments based on the TORTURE_QEMU_MAC
-# and TORTURE_QEMU_INTERACTIVE environment variables.
+# QEMU uses the last -cpu option, so emit the default before qemu-args.
 identify_qemu_args () {
-	local KVM_CPU=""
 	case "$1" in
 	qemu-system-x86_64)
-		KVM_CPU=kvm64
+		echo -cpu kvm64
 		;;
 	qemu-system-i386)
-		KVM_CPU=kvm32
+		echo -cpu kvm32
+		;;
+	qemu-system-aarch64)
+		echo -cpu host
 		;;
 	esac
+	if test -n "${3-}"
+	then
+		printf '%s\n' "$3"
+	fi
 	case "$1" in
 	qemu-system-x86_64|qemu-system-i386)
 		echo -machine q35,accel=kvm
-		echo -cpu ${KVM_CPU}
 		;;
 	qemu-system-aarch64)
-		echo -machine virt,gic-version=host -cpu host
+		echo -machine virt,gic-version=host
 		;;
 	qemu-system-ppc64)
 		echo -M pseries -nodefaults
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 957800c9ffbad..02164b6229a24 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -153,8 +153,8 @@ fi
 qemu_args="`specify_qemu_cpus "$QEMU" "$qemu_args" "$cpu_count"`"
 qemu_args="`specify_qemu_net "$qemu_args"`"
 
-# Generate architecture-specific and interaction-specific qemu arguments
-qemu_args="$qemu_args `identify_qemu_args "$QEMU" "$resdir/console.log"`"
+# Place the default CPU before existing arguments and append the other defaults.
+qemu_args="`identify_qemu_args "$QEMU" "$resdir/console.log" "$qemu_args"`"
 
 # Generate qemu -append arguments
 qemu_append="`identify_qemu_append "$QEMU"`"

base-commit: 68dcfb0e34ee3a9628f6b5ce7e06931b5248bb9e
-- 
2.43.0

