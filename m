Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795876089;
	b=laWZUsRmaXNZKF+fbovGlXKhabzcqher3yJvxrxvkXAuRSCKzee4wT2zKwd3/fh+eCj8
	 k2hmGE06AH9WRnVcDK5vuVVHOM0ANKr9CN/lE0JE145xuRSRnJn/2HgObcNWgLSN4blXd
	 DkggQm87GjClpuIO0eG9VPIROd3RsPVwuik+DgIwK3IzrhxyCL0y1fmiw4rpQMxCyEA9M
	 5eFozFI1+HSL/Mn9XtiqMvf/Fhf5cOfv3+1IE10qIVO7UYkKR41C1f/MFzyhE+amRKU6U
	 SKHK1nSX8T1phvwcKiII1sMG5I+siWd2m9tqp1i5Ji+HLc9FAvy6SaMGGnibJnwAJiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795876089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=he7nMqkjkQ0JQDd1p+ONkOp35UlWt58F62jCI8xjmd0=;
	b=JX/2e/ixZJkV3AihvEWiN3SajfDVl9wEi+IWUbSH04Dzs7clojCao91Ddel/nHre0XHB
	 Khd4zs39hK2hd49U85zt8xVf2VN4stwZ5FcZPSevvnXDoM6bmfoHcaDH7y2iKJKYFDurs
	 LrVubyKUUFceK+aaS8PODFM3pNcW9WdxCADlr3Chxbso1/RHTMpOPK3fGhLekEuGD+IM9
	 8ibh9RjpP+nugHxLDcNn/o4eX/eNRMwErHrcyKLy0Rzo6Za6xubFnuUDNdXMxbur0pQIg
	 r0WYCB8CDlRIHw7HImTmrZana/0HtChLADWvzI3lYF0gEXzYHHyNZ9o3k7hGuZ168Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gkhc613Z;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8462D606A31F
	for <rcu@vger.kernel.org>; Sat, 28 Nov 2026 14:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8462D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gkhc613Z
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6ba1e22ff4dso10728912a12.2
        for <rcu@vger.kernel.org>; Sat, 28 Nov 2026 06:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795876087; x=1796480887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=he7nMqkjkQ0JQDd1p+ONkOp35UlWt58F62jCI8xjmd0=;
        b=gkhc613Zb75x7fY1KKVuoyvdB/rWbLuID+odF1xLz5L1ZgpLnfbqiP0VvupjpEb07k
         ueFkamF8S260Uf4Fwml9NWqoml4WqaBPb2poOwDvHoiSIszp13BLTfrAub7tvaA1kywe
         H/HgWOKUjHCv5xqAdglQdyEhmm/Xe+TdeO8EGyG/mwKpt2tao/tWIpGR6ce5rFqIwAbC
         Ixkb+wKhLDzYdQCyWhUz7+mnvZ4O/tiJqBW/143beF7taJXbcCP8IZ0tvZxWAeHtG6en
         y6r3RJYK11JcKnR8fZ/KPIWCzTuyKuo1j0MuVu5PNjF2rjtkTzMK/NXgjPIE4pYdXdi0
         8Uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795876087; x=1796480887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=he7nMqkjkQ0JQDd1p+ONkOp35UlWt58F62jCI8xjmd0=;
        b=Aqa5ICa2avUwoSoJvU2luSyuZg4mJNCSMHBgnkGNrE10L9o3Apf34Gu4rYyC1eWVao
         Uw1A0lUBQgyDXKhGRSiPS9UB7fqL96g2bS45U79lE0WNdmQ5jRfFh2bGIDArXKYom1xW
         BKNpwQp41PGEqBFvRlzcMVdUP6/bM0bBvrejov4PyjBrGPo3CRO9UZrphWeKMQ8pgJvn
         olybv+4yfZHAfdN/xzznxWlP8k2pGeXWoCpNK9q+VmtKvmh7ypgarBWhf9v1nihMHlPi
         oQH7hn+hKaNQUzzliGj+P6LjNdIJh+TFXsbpMDaQk5F0bT4TzdY50Pu+vv6712snByuf
         32rQ==
X-Forwarded-Encrypted: i=1; AL+hErE3uX93wBxOXfyKYhqGInOuQm8gGmmMEtqubCM9L4bpKUqqDAYNVIQDy/27wCFB2CxzEEo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/QWbPOYboH0GOyFSDqxJyZ6FEt1Ppck4J5ajheuMTYaU3hKbtH
	A3uhCQl9K2UV60LZzkcKL2CApQOllVTpRzIC0la99z3e4bGiGcuV/hqDaYRdSE7HGNw=
X-Gm-Gg: AZFdTZevx0a7DeHS+HczS+WSKm4rzMOLXJnJ9P7/j218Ja6eD7fra0Jo86+fyOIoW91
	KVdZ8ci+U8xwWAA0HznzIkXHUCiKxwsMMJuIJIehopxdylrnHXvv7S7DaHDgOWpLHuHVxnhzPk9
	iOtD+gGlPObThVVf4UoEm5QSlL46mxIIAtd+RsXUv6sUiqKmZcdibcQeFm20Zova5W6AJgqiR9T
	Ko6l4XOYVB9qj+kGZKWZVdIagxa4Ti+wnyqRGPKs4ll8dUHR1pzUg7nrd9RjQL3ud1VrMznZiza
	5fywmf3WmU1BUqGGH0EK35Cu1AKFVMAmYI9SWdRhzYOZkLLdyQ9POPCqfg6cc2qYs6hzWp4Pned
	u0CQj0gnF4fo38hibArPNWnw+bOl39D74T3/LndZicITJGaR/YBOigu8puMxMFC+2mDbSMqukjO
	XRQzup+OAjJrnU/Lxm4H3F5W44tOZe9Cb6Zz4vhc5kOy6pAt0G5q2+SnWsnmmlpeh3YvDEw7maS
	Z/XUKVByEGvUTH2v23xp3v2wlX3cIqAse0+flNs+5BJqlhjXuGCGVrx6lmSbB5CWgGPoigUvzFq
	4nr+cpOAKDp++29z3F6TU1p+i77jZBT0cQHoRb3Kl7aUfBGPFxYRam7cRUARS2hF6mfzRr4yIJf
	T2Er8GrOk7JRPCZEz
X-Received: by 2002:a05:6402:24a3:b0:6bb:3e3f:52ec with SMTP id 4fb4d7f45d1cf-6bb3e3f5e7dmr7896038a12.22.1795876086341;
        Sat, 28 Nov 2026 06:28:06 -0800 (PST)
Received: from kernel.. ([191.40.25.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba36e35ca6sm12448436a12.4.2026.11.28.06.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 06:28:05 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH v3 5/7] rcutorture: Add kasan-aux.sh aux-stack checker
Date: Sat, 28 Nov 2026 22:27:27 +0800
Message-ID: <20261128142729.3756679-6-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128142729.3756679-1-kunwu.chan@gmail.com>
References: <20261128142729.3756679-1-kunwu.chan@gmail.com>
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

kasan-aux.sh runs dedicated aux-stack tests with kvm.sh --kasan,
existing scenarios, and the rcutorture.kasan_debug=1 and
kasan_multi_shot boot parameters.  It then verifies the recorded
caller in each intentional report's auxiliary stack, retaining the
report body and using kvm-recheck.sh for the ordinary checks.
Flavors without callback operations are expected to skip the
self-test.  Saved results can be rechecked with --check using
their batches list and QEMU commands.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 Documentation/RCU/torture.rst                 |  32 +++
 .../rcutorture/bin/kasan-aux-check.sh         | 158 ++++++++++++
 .../selftests/rcutorture/bin/kasan-aux.sh     | 228 ++++++++++++++++++
 3 files changed, 418 insertions(+)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kasan-aux-check.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kasan-aux.sh

diff --git a/Documentation/RCU/torture.rst b/Documentation/RCU/torture.rst
index 1ad5cc7938113..15a430f5111f4 100644
--- a/Documentation/RCU/torture.rst
+++ b/Documentation/RCU/torture.rst
@@ -212,6 +212,38 @@ Note that --gdb limits you to one scenario per kvm.sh run and requires
 that you have another window open from which to run ``gdb`` as instructed
 by the script.
 
+The callback enqueue-stack self-test intentionally triggers a KASAN
+use-after-free report.  Run it separately from ordinary KASAN bug hunts::
+
+	tools/testing/selftests/rcutorture/bin/kasan-aux.sh
+
+This uses ``kvm.sh --kasan``, existing scenarios, and the
+``rcutorture.kasan_debug=1`` and ``kasan_multi_shot`` boot parameters.
+The default 30-second runs cover Tree RCU, RCU Tasks, RCU Tasks Trace,
+Tree SRCU, and, except on arm64, Tiny RCU and Tiny SRCU.  Use ``--configs``
+and ``--duration`` to override the scenario list and duration.
+
+These scenarios cover the callback enqueue implementations that record
+KASAN auxiliary stacks, rather than all RCU configuration combinations.
+Flavors with no callback operations, such as Tasks Rude, are expected
+to skip the self-test, and the checker requires their skip message and
+a successful ordinary run.  Any other skip fails the check, even if
+the ordinary torture run succeeds.
+
+The script requires exactly one intentional report per supported scenario, with
+``rcu_test_kasan()`` in its "Last potentially related work creation"
+stack, followed by successful completion of the same torture flavor.
+Only the verified report's diagnostic markers are filtered; the body
+is retained for the existing checks, including the configuration,
+build, and console checks that ``kvm-recheck.sh`` runs.  The original
+logs and the underlying ``kvm.sh`` runtime-error status are preserved.
+Saved results can be rechecked with ``kasan-aux.sh --check
+results-directory``, using the saved ``batches`` file and QEMU commands.
+As with the intentional warnings tested by ``srcu_lockdep.sh``, ordinary
+``kvm-recheck.sh`` and ``kvm-find-errors.sh`` still report the raw
+diagnostic; use the dedicated check to distinguish the expected report
+from failures.
+
 Kernel boot arguments can also be supplied, for example, to control
 rcutorture's module parameters.  For example, to test a change to RCU's
 CPU stall-warning code, use "--bootargs 'rcutorture.stall_cpu=30'".
diff --git a/tools/testing/selftests/rcutorture/bin/kasan-aux-check.sh b/tools/testing/selftests/rcutorture/bin/kasan-aux-check.sh
new file mode 100755
index 0000000000000..7a6f425975207
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kasan-aux-check.sh
@@ -0,0 +1,158 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Verify the intentional rcutorture KASAN report and remove its diagnostics.
+# Flavors without callback operations must instead show the expected skip.
+# Leave all other console output for the usual torture error checks.
+#
+# Authors: Kunwu Chan <kunwu.chan@gmail.com>
+#
+# Usage: kasan-aux-check.sh console.log flavor
+
+if test "$#" -ne 2 || ! test -r "$1"
+then
+	echo "Usage: $0 console.log flavor" >&2
+	exit 1
+fi
+
+awk -v flavor="$2" '
+BEGIN {
+	timestamp = "[[:space:]]*[0-9]+\\.[0-9]+";
+	caller = "[[:space:]]*[CT][[:space:]]*[0-9]+";
+	log_prefix = "^[[:space:]]*\\[(" timestamp "|" caller ")\\][[:space:]]*";
+	frame_prefix = "^(\\[<[[:xdigit:]]+>\\][[:space:]]*)?\\??[[:space:]]*";
+	frame_suffix = "([.][[:alnum:]_.]+)?\\+0x[[:xdigit:]]+/0x[[:xdigit:]]+([[:space:]]|$)";
+	test_name = "rcutorture: WARN: KASAN aux-stack call_" flavor "()";
+	success = flavor "-torture:--- End of test: SUCCESS: ";
+	skip_name = "rcutorture: " flavor " has no callback/barrier ops, skipping KASAN test";
+	skip_mode = flavor ~ /^(tasks-rude|busted|trivial)$/;
+}
+
+function fail(message)
+{
+	print "kasan-aux-check.sh: " message " at line " NR > "/dev/stderr";
+	failed = 1;
+	exit 1;
+}
+
+# Strip printk timestamps/caller IDs for matching, retaining the original line.
+function message(line)
+{
+	sub(/\r$/, "", line);
+	sub(/^<[0-9]+>/, "", line);
+	while (sub(log_prefix, "", line))
+		;
+	sub(/^[[:space:]]+/, "", line);
+	sub(/[[:space:]]+$/, "", line);
+	return line;
+}
+
+function frame(line, symbol)
+{
+	return line ~ (frame_prefix symbol frame_suffix);
+}
+
+{
+	line = message($0);
+	if (skip_mode) {
+		if (line == skip_name) {
+			if (++skips != 1 || succeeded)
+				fail("unexpected or late skip message");
+		} else if (line ~ /skipping KASAN test|KASAN aux-stack test skipped|not testing KASAN aux stack/)
+			fail("unexpected skip message");
+		if (line ~ /End of test: SUCCESS:/) {
+			if (index(line, success) != 1 || ++succeeded != 1 || skips != 1)
+				fail("unexpected SUCCESS marker");
+		} else if (line ~ /End of test:/)
+			fail("unexpected test result");
+		if (line ~ /^rcutorture: WARN: KASAN aux-stack/ || line ~ /BUG: KASAN:/)
+			fail("unexpected aux-stack test output");
+		print;
+		next;
+	}
+	if (line ~ /skipping KASAN test|KASAN aux-stack test skipped|not testing KASAN aux stack/)
+		fail("KASAN test was skipped");
+	if (line ~ /^rcutorture: WARN: KASAN aux-stack call_[-[:alnum:]_]+\(\) test starting\.$/) {
+		if (line != test_name " test starting." ||
+		    ++started != 1 || reports || completed || succeeded)
+			fail("unexpected test start");
+		next;
+	}
+	if (line ~ /^rcutorture: WARN: KASAN aux-stack call_[-[:alnum:]_]+\(\) test complete\.$/) {
+		if (line != test_name " test complete." ||
+		    ++completed != 1 || started != 1 || reports != 1 || in_report)
+			fail("unexpected test completion");
+		next;
+	}
+	if (line ~ /End of test: SUCCESS:/) {
+		if (index(line, success) != 1 ||
+		    ++succeeded != 1 || completed != 1 || in_report)
+			fail("unexpected SUCCESS marker");
+	}
+	else if (line ~ /End of test:/)
+		fail("unexpected test result");
+	if (line ~ /BUG: KASAN:/) {
+		if (line !~ ("^BUG: KASAN: slab-use-after-free in rcu_test_kasan" frame_suffix))
+			fail("unexpected KASAN report");
+		if (in_report || !separator || started != 1 || completed || ++reports != 1)
+			fail("unexpected or unbounded KASAN report");
+		report_separator = message(separator);
+		printf "%s", before_report;
+		before_report = "";
+		separator = "";
+		in_report = 1;
+		next;
+	}
+	if (in_report) {
+		if (line == report_separator) {
+			if (reads != 1 || traces != 1 || aux_stacks != 1 || !test_frame)
+				fail("incomplete KASAN report or missing caller in auxiliary stack");
+			in_report = 0;
+			next;
+		}
+		if (line ~ /^(Read|Write) of size /) {
+			if (line !~ /^Read of size 1 at addr / || ++reads != 1)
+				fail("unexpected KASAN access");
+		}
+		if (line == "Last potentially related work creation:") {
+			if (++aux_stacks != 1)
+				fail("duplicate auxiliary stack");
+			in_aux = 1;
+		}
+		else if (in_aux) {
+			if (!frame(line, "[[:alnum:]_]+"))
+				in_aux = 0;
+			else if (frame(line, "rcu_test_kasan"))
+				test_frame = 1;
+		}
+		# Suppress only the main trace title in the expected report.
+		if (line ~ /^Call [Tt]race:$/ && ++traces == 1)
+			next;
+		print;
+		next;
+	}
+	if (started && !reports && line ~ /^=+$/) {
+		if (separator) {
+			print separator;
+			printf "%s", before_report;
+		}
+		separator = $0;
+		before_report = "";
+		next;
+	}
+	if (separator) {
+		before_report = before_report $0 "\n";
+		next;
+	}
+	print;
+}
+
+END {
+	if (failed)
+		exit 1;
+	if (skip_mode) {
+		if (skips != 1 || succeeded != 1)
+			fail("missing skip message or SUCCESS marker");
+	} else if (in_report || started != 1 || completed != 1 || succeeded != 1 || reports != 1)
+		fail("missing test markers or truncated KASAN report");
+}' < "$1" || exit 1
diff --git a/tools/testing/selftests/rcutorture/bin/kasan-aux.sh b/tools/testing/selftests/rcutorture/bin/kasan-aux.sh
new file mode 100755
index 0000000000000..ae7896658e94d
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kasan-aux.sh
@@ -0,0 +1,228 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Run and check the intentional KASAN callback enqueue-stack tests.
+#
+# Authors: Kunwu Chan <kunwu.chan@gmail.com>
+
+scriptname=$0
+RCUTORTURE="$(pwd)/tools/testing/selftests/rcutorture"; export RCUTORTURE
+PATH=${RCUTORTURE}/bin:$PATH; export PATH
+. functions.sh
+
+usage () {
+	echo "Usage: $scriptname [ --datestamp string ] [ --duration time ]"
+	echo "       [ --configs \"existing scenario list\" ]"
+	echo "       $scriptname --check results-directory"
+	exit 1
+}
+
+ds="$(date +%Y.%m.%d-%H.%M.%S)-kasan-aux"
+duration=30s
+configs="TREE03 TASKS01 TRACE01 SRCU-P"
+if test "$(uname -m)" != aarch64
+then
+	configs="$configs TINY01 SRCU-T"
+fi
+checkdir=
+while test $# -gt 0
+do
+	case "$1" in
+	--check)
+		checkarg --check "(results directory)" "$#" "$2" '.' '^--'
+		checkdir=$2
+		shift
+		;;
+	--configs)
+		checkarg --configs "(scenario list)" "$#" "$2" '^[^/.a-z]\+$' '^--'
+		configs=$2
+		shift
+		;;
+	--datestamp)
+		checkarg --datestamp "(relative pathname)" "$#" "$2" '^[a-zA-Z0-9._/-]*$' '^--'
+		ds=$2
+		shift
+		;;
+	--duration)
+		checkarg --duration "(time)" "$#" "$2" '^[0-9][0-9]*[smhd]\?$' '^--'
+		duration=$2
+		shift
+		;;
+	"")
+		;;
+	*)
+		usage
+		;;
+	esac
+	shift
+done
+
+T="$(mktemp -d "${TMPDIR-/tmp}/kasan-aux.sh.XXXXXX")" || exit 1
+trap 'rm -rf "$T"' EXIT
+nsupported=0
+
+# Keep raw logs intact and let the ordinary recheck handle the verified output.
+check_results () {
+	local rundir config dir copy flavor f configs
+	local work="$T/results"
+
+	rundir=$(cd "$1" && pwd) || return 1
+	if ! test -s "$rundir/batches" || ! test -r "$rundir/log"
+	then
+		echo "$rundir: missing batches or log"
+		return 1
+	fi
+	configs=$(awk '!/^#/ { print $2 }' "$rundir/batches")
+	if test -z "$configs"
+	then
+		echo "$rundir: empty scenario list"
+		return 1
+	fi
+	mkdir "$work" || return 1
+	ln -s "$rundir/log" "$work/log" || return 1
+	echo rcu > "$work/torture_suite"
+	if test -f "$rundir/re-run"
+	then
+		ln -s "$rundir/re-run" "$work/re-run" || return 1
+	fi
+	for config in $configs
+	do
+		dir="$rundir/$config"
+		copy="$work/$config"
+		mkdir "$copy" || return 1
+		# Link inputs only, so recheck cannot overwrite saved diagnostics.
+		for f in .config ConfigFragment ConfigFragment.input Make.defconfig.out Make.out qemu-cmd qemu-retval
+		do
+			if ! test -r "$dir/$f"
+			then
+				echo "$config: missing $f"
+				return 1
+			fi
+			ln -s "$dir/$f" "$copy/$f" || return 1
+		done
+		for f in Make.oldconfig.err Warnings vmlinux vmlinux.xz
+		do
+			ln -s "$dir/$f" "$copy/$f" || return 1
+		done
+		if ! grep -q '^CONFIG_KASAN_GENERIC=y$' "$dir/.config" ||
+		   test "$(cat "$dir/qemu-retval")" != 0
+		then
+			echo "$config: Generic KASAN required and QEMU must exit normally"
+			return 1
+		fi
+		# kvm.sh saves a single QEMU command with a double-quoted -append string.
+		# Read it once, retaining the last flavor parameter, as the kernel does.
+		if ! flavor=$(awk '
+			BEGIN { flavor = "rcu"; }
+			/^[[:space:]]*(#|$)/ { next; }
+			{
+				if (++commands != 1 ||
+				    !match($0, /(^|[[:space:]])-append[[:space:]]+"/))
+					exit 1;
+				args = substr($0, RSTART + RLENGTH);
+				if (!sub(/"[^"]*$/, "", args))
+					exit 1;
+				# Only the plain kvm.sh-generated format is supported.
+				if (args ~ /\\/)
+					exit 1;
+				# Keep quoted kernel parameter values together.
+				while (args ~ /[^[:space:]]/) {
+					sub(/^[[:space:]]+/, "", args);
+					if (!match(args, /^([^"[:space:]]|"[^"]*")+/))
+						exit 1;
+					word = substr(args, 1, RLENGTH);
+					args = substr(args, RLENGTH + 1);
+					if (args !~ /^([[:space:]]|$)/)
+						exit 1;
+					whole_quote = sub(/^"/, "", word);
+					equals = index(word, "=");
+					param = equals ? substr(word, 1, equals - 1) : word;
+					value = equals ? substr(word, equals + 1) : "";
+					value_quote = sub(/^"/, "", value);
+					if (whole_quote || value_quote) {
+						if (equals)
+							sub(/"$/, "", value);
+						else
+							sub(/"$/, "", param);
+					}
+					if (param == "--" && !equals)
+						break;
+					gsub(/-/, "_", param);
+					if (param == "rcutorture.torture_type")
+						flavor = value;
+					if (param == "kasan_multi_shot")
+						multi_shot = 1;
+				}
+				valid = 1;
+			}
+		END {
+			if (!valid || commands != 1 || !multi_shot ||
+			    flavor !~ /^(rcu|srcu|srcud|tasks|tasks-tracing|tasks-rude|busted|trivial)$/)
+				exit 1;
+			print flavor;
+		}' "$dir/qemu-cmd")
+		then
+			echo "$config: invalid saved boot arguments or missing kasan_multi_shot"
+			return 1
+		fi
+		case "$flavor" in
+		rcu|srcu|srcud|tasks|tasks-tracing)
+			nsupported=$((nsupported+1))
+			;;
+		esac
+		if ! TMPDIR="$T" kasan-aux-check.sh "$dir/console.log" "$flavor" > "$copy/console.log"
+		then
+			return 1
+		fi
+		# kvm-recheck.sh does not propagate parse-build.sh exit status.
+		TMPDIR="$T" parse-build.sh "$dir/Make.out" "$config" || return 1
+	done
+	if ! TMPDIR="$T" kvm-recheck.sh "$work" 2> "$T/recheck.err" || test -s "$T/recheck.err"
+	then
+		cat "$T/recheck.err"
+		return 1
+	fi
+	echo "Summary: KASAN aux-stack checks passed"
+}
+
+if test -n "$checkdir"
+then
+	check_results "$checkdir"
+	exit $?
+fi
+
+rundir="$RCUTORTURE/res/$ds"
+if test -e "$rundir"
+then
+	echo "Results directory already exists: $rundir"
+	exit 1
+fi
+kvm.sh --allcpus --kasan --kconfig "CONFIG_KASAN_GENERIC=y" \
+	--configs "$configs" --duration "$duration" --trust-make \
+	--bootargs "rcutorture.kasan_debug=1 rcutorture.object_debug=0 kasan_multi_shot" \
+	--datestamp "$ds"
+ret=$?
+err=0
+if ! check_results "$rundir" > "$T/check.out" 2>&1
+then
+	err=1
+fi
+# Scenarios with callback operations produce the intentional reports, so
+# kvm.sh must report them as runtime errors.  Skip-only selections exit 0.
+if test "$nsupported" -gt 0
+then
+	expected=3
+else
+	expected=0
+fi
+if test "$ret" -ne "$expected"
+then
+	echo "Expected kvm.sh exit status $expected, got $ret"
+	err=1
+fi
+cat "$T/check.out"
+if test -d "$rundir"
+then
+	cat "$T/check.out" >> "$rundir/log"
+fi
+exit "$err"
-- 
2.43.0

