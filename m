Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B30629AAEA;
	Wed,  9 Jul 2025 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057910; cv=none; b=r31P/D+WnwknEL5REtdPTLCxUOikZEzMjXcH/0ye/AlWwdPtJJ0te1wAzPM9id5KJZGU7E7i+mJmAeh1LmXgfK97H0Et7O/eEENK3/2p/1iS5nErHjVo6hMfFCCFJp5FJzWm68FyGoWXR0I6BER4S/+NDfNqQrc0KN2w/PNe8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057910; c=relaxed/simple;
	bh=zqUVwzGDgrUyNXsRAjKupnuL6Uyciw2COrK5MWyo+gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXQ/Q8rXfFY4GsT/uePOqcVcUMkvbeAPd6CdICEOMz5WvDR6HNGde/ARE7JK6ltiTTUzGqbgCypfdSqS+LbcA3kO9J/4rDQm6NJXBmfeGfww9uY0zjt6yf+bN/fojK/mcTkO4r51LLjGLnb3q0mvR/SCmxuyqwRIZMJ5aq5Tjek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oc0CbU7U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oc0CbU7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E83C4CEEF;
	Wed,  9 Jul 2025 10:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057910;
	bh=zqUVwzGDgrUyNXsRAjKupnuL6Uyciw2COrK5MWyo+gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oc0CbU7UdaQCJrIu4+Tpgk9QSktcfym2x8xOZx9TeRDLuK3w9Rx+jO/iDpVp6H+vZ
	 VzAwdW32FACixIEBW9081BMSny8EM1xZVd60pG4qr3AItTUHcgEQmGRDOEvzhFSLds
	 iDJWlQ5IJltun6xFgR2t3K2BILvBxHpelwdKdeojH7x+NaABHlCK7wzzE8q2IMOvG9
	 sjgFhHeP+a0jHDOBJm0by6Qn081laIj7xeyCNxIdoAn1s9KbfmwRf8KjTX3wT0F7XF
	 iYCWXRAZWmiG3tMw9beEZeDkQq/LitjAN/QMv+FqmHFAU7hNRWjYlpXtvioLUtQUcb
	 xzj+BsuAQaxvQ==
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
Subject: [PATCH rcu 07/13] torture: Suppress "find" diagnostics from torture.sh --do-none run
Date: Wed,  9 Jul 2025 16:14:08 +0530
Message-Id: <20250709104414.15618-8-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104414.15618-1-neeraj.upadhyay@kernel.org>
References: <20250709104414.15618-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

When torture.sh is told to do nothing, it produces a couple of distracting
diagnostics from the "find" command:

	find: ‘’: No such file or directory
	find: ‘’: No such file or directory

This is pointless chatter and could cause confusion.  This commit therefore
suppresses these diagnostics when there is nothing to find.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 420c551b824b..ed59bd43d4f8 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -719,8 +719,11 @@ fi
 echo Started at $startdate, ended at `date`, duration `get_starttime_duration $starttime`. | tee -a $T/log
 echo Summary: Successes: $nsuccesses Failures: $nfailures. | tee -a $T/log
 tdir="`cat $T/successes $T/failures | head -1 | awk '{ print $NF }' | sed -e 's,/[^/]\+/*$,,'`"
-find "$tdir" -name 'ConfigFragment.diags' -print > $T/configerrors
-find "$tdir" -name 'Make.out.diags' -print > $T/builderrors
+if test -n "$tdir"
+then
+	find "$tdir" -name 'ConfigFragment.diags' -print > $T/configerrors
+	find "$tdir" -name 'Make.out.diags' -print > $T/builderrors
+fi
 if test -s "$T/configerrors"
 then
 	echo "  Scenarios with .config errors: `wc -l "$T/configerrors" | awk '{ print $1 }'`"
-- 
2.40.1

