Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD9029E0E7;
	Mon, 29 Dec 2025 19:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035640; cv=none; b=KnH9yuBYEGFhOsLAUURPSw6WdM+OUab94H73E4OcsSKzarLBdm4lCmgj2IqgBp9rH1+2XPILZsO/+9+9o6BlqgthwcM7QLlp05jygJBT/wcBVcwwJhizAsoLlvVUijJapwmYIsUs2VU9yQwmxTP4z/QLo6d6zzIyx6FH2KA1qas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035640; c=relaxed/simple;
	bh=UTOxcHLmC9q+RICTp69cbr7jLQ1LWnbzy9IJr39Ft4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kONaHoC0Y/wSGvxBMUOVUBwKTeFNZrYFa7dTLDWjBN49ge+RqupiSCmcfm1tZEf0rYilxrgvHqCX+pEccshlUawxK3UHpAukkAyUmCPs6Qq77zMKdTIr44GAONzJHZPzMmQD5lxfpo3ZLZ7QoFYi6FVr5QRSPoCbk5LWi9HDJaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmzxpgZR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmzxpgZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE882C16AAE;
	Mon, 29 Dec 2025 19:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767035640;
	bh=UTOxcHLmC9q+RICTp69cbr7jLQ1LWnbzy9IJr39Ft4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmzxpgZRKWD9qe7zhusEx+lcOKRc1iiHdhB0TRskeOdRVHOiSOdwRymoaQOHWFRwb
	 1grR1Ww/tW3gf1TILyP3wVmqPWnobNf1vzlE4lWu7t4XdB/6X/yzzbsg7B2XOqLHVp
	 EiwNQPzcUvHiDGmHrWAdjQqHRkq1MinBZrCLqjncDDXIV2jawsZ4zpo16WUgfEK5ks
	 Yxb1sV7rgnnEe8m8LErxcjcf8HVurxM1Nb5IQDO43LQyGlREXaT6bnOidGM8601sbU
	 GdpHpvF4I2f0EnGre2jRErapYwe3Wng4rcghCkE8GdwiNRBVhdEU6Ygxim3WFM5AXj
	 yXLYpFKUgclYg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9295BCE0E29; Mon, 29 Dec 2025 11:13:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 3/6] torture: Make kvm-series.sh give build numbers and totals
Date: Mon, 29 Dec 2025 11:13:55 -0800
Message-Id: <20251229191358.693753-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <eb69cddd-2e89-43a5-ba61-95af1d820dc0@paulmck-laptop>
References: <eb69cddd-2e89-43a5-ba61-95af1d820dc0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kvm-series.sh script can easily be convinced to do on the order
of 1,000 builds, so some sort of progress indicator would be helpful.
This commit therefore updates the "Starting" output lines to read
as in the following example, adding the ("2 of 4"):

Starting TREE01/1.7e0ad1b49057 (2 of 4) at Sat Nov 8 10:08:21 PM PST 2025

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-series.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-series.sh b/tools/testing/selftests/rcutorture/bin/kvm-series.sh
index d020d0672023a..29a2cd64835fd 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-series.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-series.sh
@@ -32,6 +32,7 @@ then
 	echo "$0: Repetition ('*') not allowed in config list."
 	exit 1
 fi
+config_list_len="`echo ${config_list} | wc -w | awk '{ print $1; }'`"
 
 commit_list="${2}"
 if test -z "${commit_list}"
@@ -47,6 +48,7 @@ then
 	exit 2
 fi
 sha1_list=`cat $T/commits`
+sha1_list_len="`echo ${sha1_list} | wc -w | awk '{ print $1; }'`"
 
 shift
 shift
@@ -80,6 +82,8 @@ echo " --- Results directory: " $ds | tee -a $T/log
 # turning preemption on and off.  Defer actual runs in order to run
 # lots of them concurrently on large systems.
 touch $T/torunlist
+n2build="$((config_list_len*sha1_list_len))"
+nbuilt=0
 for config in ${config_list}
 do
 	sha_n=0
@@ -87,7 +91,7 @@ do
 	do
 		sha1=${sha_n}.${sha} # Enable "sort -k1nr" to list commits in order.
 		echo
-		echo Starting ${config}/${sha1} at `date` | tee -a $T/log
+		echo Starting ${config}/${sha1} "($((nbuilt+1)) of ${n2build})" at `date` | tee -a $T/log
 		git checkout --detach "${sha}"
 		tools/testing/selftests/rcutorture/bin/kvm.sh --configs "$config" --datestamp "$ds/${config}/${sha1}" --duration 1 --build-only --trust-make "$@"
 		curret=$?
@@ -115,6 +119,7 @@ do
 			ret=${curret}
 		fi
 		sha_n=$((sha_n+1))
+		nbuilt=$((nbuilt+1))
 	done
 done
 
-- 
2.40.1

