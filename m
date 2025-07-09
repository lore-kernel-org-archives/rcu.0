Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E493298CD2;
	Wed,  9 Jul 2025 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057927; cv=none; b=e8Cu62+9q2iPkbCwXoHvlA+7F/pwoA+nXSzsU0uavmw4UNjL5B7XpXrEYelAAlk14FR8lRDHhP+cWbcaGkIrOuV9q6jne0wZxse1vuCnWmpgg95cvhu2B/whvKzeVy5cszYBwPmNIuT/3pUIQ4sIDVdBJOpTR4geejbYvSacJzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057927; c=relaxed/simple;
	bh=ahQVzWu8tujb8R70sKRbUWTUTgcJb/2sLahw0vr2NHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LxZAwKJG/FhLfomEZQHXyFS2NVt8m0xS0gUsRKsDSwHFCIdcauHWbz7PviQfWATECl05oLFgoVGVJzfi6OeNWAYlT67s98iMpxRei2C5xoS6juIyaCg/j3XgleBbfo7JfPKQm6RVzVVN/A6O89rc/yhPpHlk0Ar2POQ03jhE3Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ss5fE3IU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ss5fE3IU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3D1C4CEEF;
	Wed,  9 Jul 2025 10:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057926;
	bh=ahQVzWu8tujb8R70sKRbUWTUTgcJb/2sLahw0vr2NHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ss5fE3IUsUkUp8uxeQumZFxRIM515qSyEJEMSXmitIyxbTaagbJvwtM8jt7H64P03
	 QR0vRC8FozQGLVrp34sefJhP9/xWOdW4fzIIpvLGNkkLfHZelWkyrW6Dh0kukIL4IX
	 Ca358Bj0KAVW7ixCRfXr4eHLmPBEZhTK5ZG7B2JtRwMqzHKqbBvAd2MnnGuQhdTm2X
	 eb3mrldurl/QdY7qbS7Uoc02txyLWYtfDBFIn6CZnUpbp9wn3MpSQuvGt6xiQua+Gn
	 6IuKeOU3jRpQmAZ48Bh5p2ki2D/3N9PO0VlaMZspNu4ZUkAYigxuD8AdBYGqxl2Hkf
	 uWls1zHH5zi7g==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 10/13] torture: Make torture.sh tolerate runs having bad kvm.sh arguments
Date: Wed,  9 Jul 2025 16:14:11 +0530
Message-Id: <20250709104414.15618-11-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104414.15618-1-neeraj.upadhyay@kernel.org>
References: <20250709104414.15618-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, torture.sh assumes excessive levels of reviewer competence
and thus fails to gracefully handle cases where it is tricked into giving
kvm.sh invalid arguments.  This commit therefore upgrades error handling
to more gracefully handle this situation.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 .../selftests/rcutorture/bin/torture.sh       | 28 +++++++++++++++----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index a7a8e801283d..39844d213da5 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -378,13 +378,19 @@ function torture_set {
 	then
 		curflavor=$flavor
 		torture_one "$@"
-		mv $T/last-resdir $T/last-resdir-nodebug || :
+		if test -e $T/last-resdir
+		then
+			mv $T/last-resdir $T/last-resdir-nodebug || :
+		fi
 	fi
 	if test "$do_kasan" = "yes"
 	then
 		curflavor=${flavor}-kasan
 		torture_one "$@" --kasan
-		mv $T/last-resdir $T/last-resdir-kasan || :
+		if test -e $T/last-resdir
+		then
+			mv $T/last-resdir $T/last-resdir-kasan || :
+		fi
 	fi
 	if test "$do_kcsan" = "yes"
 	then
@@ -400,7 +406,10 @@ function torture_set {
 			chk_rdr_state="CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE=y"
 		fi
 		torture_one "$@" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y ${kcsan_expert} ${chk_rdr_state}" $kcsan_kmake_tag $cur_kcsan_kmake_args --kcsan
-		mv $T/last-resdir $T/last-resdir-kcsan || :
+		if test -e $T/last-resdir
+		then
+			mv $T/last-resdir $T/last-resdir-kcsan || :
+		fi
 	fi
 }
 
@@ -704,7 +713,14 @@ nfailures=0
 echo FAILURES: | tee -a $T/log
 if test -s "$T/failures"
 then
-	awk < "$T/failures" -v sq="'" '{ print "echo " sq $0 sq; print "sed -e " sq "1,/^ --- .* Test summary:$/d" sq " " $2 "/log | grep Summary: | sed -e " sq "s/^[^S]*/  /" sq; }' | sh | tee -a $T/log | tee "$T/failuresum"
+	awk < "$T/failures" -v sq="'" '
+	{
+		print "echo " sq $0 sq;
+		if ($2 != "")
+			print "sed -e " sq "1,/^ --- .* Test summary:$/d" sq " " $2 "/log | grep Summary: | sed -e " sq "s/^[^S]*/  /" sq;
+		else
+			print "echo " sq "  " sq "Run failed to produce results directory.";
+	}' | sh | tee -a $T/log | tee "$T/failuresum"
 	nfailures="`wc -l "$T/failures" | awk '{ print $1 }'`"
 	grep "^  Summary: " "$T/failuresum" |
 		grep -v '^  Summary: Bugs: [0-9]* (all bugs kcsan)$' > "$T/nonkcsan"
@@ -714,13 +730,13 @@ then
 	fi
 	ret=2
 fi
-if test "$do_kcsan" = "yes"
+if test "$do_kcsan" = "yes" && test -e tools/testing/selftests/rcutorture/res/$ds
 then
 	TORTURE_KCONFIG_KCSAN_ARG=1 tools/testing/selftests/rcutorture/bin/kcsan-collapse.sh tools/testing/selftests/rcutorture/res/$ds > tools/testing/selftests/rcutorture/res/$ds/kcsan.sum
 fi
 echo Started at $startdate, ended at `date`, duration `get_starttime_duration $starttime`. | tee -a $T/log
 echo Summary: Successes: $nsuccesses Failures: $nfailures. | tee -a $T/log
-tdir="`cat $T/successes $T/failures | head -1 | awk '{ print $NF }' | sed -e 's,/[^/]\+/*$,,'`"
+tdir="`cat $T/successes $T/failures | awk 'NF > 1 { print $NF }' | head -1 | sed -e 's,/[^/]\+/*$,,'`"
 if test -n "$tdir"
 then
 	find "$tdir" -name 'ConfigFragment.diags' -print > $T/configerrors
-- 
2.40.1

