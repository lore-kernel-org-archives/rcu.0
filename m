Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7F7295DB4;
	Wed,  9 Jul 2025 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057881; cv=none; b=qijbvzJ6KfsHzcpnABU3EcIY7odS4YwtfaxUqsNPR7NYMCnoM0NNQid6s9dOB2qDuNCi3uRe12/jUaUSOl+3W2CH4X7QHZV8AR++CjTSM/wQuuKGHb2Qp2zUgv8sx/2n05qRM1nGl0fRVf4UTvSfX5k6G+dFb7X16es5cblFgNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057881; c=relaxed/simple;
	bh=rQNQFE/ZZfiCg3nCWCzS+MuDWRpJAMAtQMbF0HNbV98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dd2TCZkcZDSNIoF7NYNAgXzHhOpG4CXWAQ3/+dODcjDqAWnbGQnifj2LXRZ/40HQ5NFlDvVwgRyDk41BWjzZOUbUonBrvUoWtdtVaJ0VDv4Eaggn2H5qrpG1eDSjzk3RY7aVK2S7XLXDRhT9nCbdNL1NOAh7dBZcbmir8evZc4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOIEbUpJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOIEbUpJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB327C4CEF5;
	Wed,  9 Jul 2025 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057880;
	bh=rQNQFE/ZZfiCg3nCWCzS+MuDWRpJAMAtQMbF0HNbV98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UOIEbUpJel3hqIyNmYvhCrb7AIRSOMIq9rLALscyUnUN2skFxT6pUIdBTOzX6MFPw
	 EcbLWPqU0xL8TFZv6ihdQB9StuhFzjjVj724KKoFE0aNuZpOW9Aw3YIvcTVmGrDMde
	 exV5h0INNe90SK/SXFqGujnfoSCHM3sxvde1BO0wWXPJy1rrXsPeTfqta9AgaZHavw
	 c7/mp6E/XMtf0GJnqlJeCPg4QELf8Av48J5xGjPXMfJ+J8uZEGdb5HfUIhwI9HLeeM
	 Vu5t12MwvFO0QKr5m1Dr4ZVIAyYYNZPjB9wnmGMHBUVm3Vut5XKDCX3y02gfeBpKRq
	 UkdHuNr84QRvA==
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
Subject: [PATCH rcu 02/13] torture: Permit multiple space characters in kvm.sh --kconfig argument
Date: Wed,  9 Jul 2025 16:14:03 +0530
Message-Id: <20250709104414.15618-3-neeraj.upadhyay@kernel.org>
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

The straightforward way of doing bash substitution for optional strings
leaves a pair of space characters, which the kvm.sh --kconfig option
rejects as ill-formed.  This commit therefore changes the corresponding
regular expression to accommodate more than one space character between
successive Kconfig options.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 42e5e8597a1a..9c1b850b3227 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -199,7 +199,7 @@ do
 		fi
 		;;
 	--kconfig|--kconfigs)
-		checkarg --kconfig "(Kconfig options)" $# "$2" '^\(#CHECK#\)\?CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\|"[^"]*"\)\( \(#CHECK#\)\?CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\|"[^"]*"\)\)*$' '^error$'
+		checkarg --kconfig "(Kconfig options)" $# "$2" '^\(#CHECK#\)\?CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\|"[^"]*"\)\( \+\(#CHECK#\)\?CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\|"[^"]*"\)\)* *$' '^error$'
 		TORTURE_KCONFIG_ARG="`echo "$TORTURE_KCONFIG_ARG $2" | sed -e 's/^ *//' -e 's/ *$//'`"
 		shift
 		;;
-- 
2.40.1

