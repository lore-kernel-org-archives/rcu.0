Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD1229DB99;
	Mon, 29 Dec 2025 19:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035640; cv=none; b=FMeol7Vm0c2xLvVotaXUv1LrqR4+Xp4xcT0mipXT4razr2ldwEhJ6PcWhRVwSiAYFtzd7NjOwfNzmSbBKEKLuU1C7jDJMzzIyv74gmxpz2fTwlxIREO25yNRVkfRVu2+jfTx/vv6bOXRWUN3ODrE7ah2EKKAjLD+1t/k8zunCwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035640; c=relaxed/simple;
	bh=EvhGlhlfv9Y3ZizK23Gd9rpD3qZ8iEJIkdoyNj7aKmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZlPm+bba2EE5INQ6y84B5Km5Xu3fnUPqcHBvvoT8b3YPqft5ziLDp5RYLdfZ9hRH2qXCmLeKYkj/rwDMqqqT1YEgvOEg9oCpwa6kheYIsrWJZl0tor2yWTYgFiKXOW0zVX+6nG6H/2BEOth7XEnGfcSl7To4BF50e9d84rbHgww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kn0lANO/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kn0lANO/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45763C19422;
	Mon, 29 Dec 2025 19:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767035640;
	bh=EvhGlhlfv9Y3ZizK23Gd9rpD3qZ8iEJIkdoyNj7aKmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kn0lANO/IDRNVRx97vZMYFo6eYVUZ+DJxn60k6nuntES59adowMy5PkMZeZ/2YsE7
	 k6qe5D+vuGQ8Rhh6zBMEj1X/KBtNHH8gNPIrfLfZvju0NgHC5RBo8/TNx0qXyFh1y4
	 URCyiVxDZZMkqBF+sTNB5qvUrpDTJmv38zrAXr+bhXxmqXHEASRrxgt+9Cr6CR6LuF
	 9nE65CTN269vjxiPmNcFlg/1yy0YLPCxwMfzmAzvn3mIcOmLM0P0lzgjnOanfKrkew
	 9nw03WSHMwksG6oQ0yll/ECOvhFoV2PLkyLVMYSoFynOzRJAOi26NGXxGaPX7SezLw
	 NFTTm6GijJXxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9A7D5CE10F4; Mon, 29 Dec 2025 11:13:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 6/6] torture: Include commit discription in testid.txt
Date: Mon, 29 Dec 2025 11:13:58 -0800
Message-Id: <20251229191358.693753-6-paulmck@kernel.org>
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

Currently, the testid.txt file in the top-level directory of the
rcutorture results contains the output of "git rev-parse HEAD", which
just gives the full SHA-1 of the current commit.  This is followed by
the output of "git status", which is further followed by the output of
"git diff".  This works, but is less than helpful to human readers
scanning a list of commits.

This commit therefore instead uses "git show --oneline --no-patch HEAD",
which provides a short SHA-1, but also the names of any branches and
the commit's title.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/mktestid.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/mktestid.sh b/tools/testing/selftests/rcutorture/bin/mktestid.sh
index 16f9907a4dae0..24f6261dab6ab 100755
--- a/tools/testing/selftests/rcutorture/bin/mktestid.sh
+++ b/tools/testing/selftests/rcutorture/bin/mktestid.sh
@@ -18,7 +18,7 @@ fi
 echo Build directory: `pwd` > ${resdir}/testid.txt
 if test -d .git
 then
-	echo Current commit: `git rev-parse HEAD` >> ${resdir}/testid.txt
+	echo Current commit: `git show --oneline --no-patch HEAD` >> ${resdir}/testid.txt
 	echo >> ${resdir}/testid.txt
 	echo ' ---' Output of "'"git status"'": >> ${resdir}/testid.txt
 	git status >> ${resdir}/testid.txt
-- 
2.40.1

