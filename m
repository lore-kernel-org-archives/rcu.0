Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DA5230BD0;
	Thu,  8 May 2025 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747754; cv=none; b=CLWWkQw5URC4NK7bxec52876GG8rjNjn46UN46ULQaJ4EvaCH6EdGX9CNiJmGwDhvj3liPo3O0tj880LblAHsTK2Y9GO9mw3N6NhOc6OUeuqoxppg99hVZztKxziUA8FNgXMLJe2hQS659jwW+n6ViEk9coNxi1ctZZfMaWSJgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747754; c=relaxed/simple;
	bh=xkjlkRzXy3gD07TO4pnDWxA5oWDgHXa+wX7fIFSjXqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nTurzblRj0jXBsiBo0wqBFKXW44mWrUH6JyEGXU6nNLjxoaLGp1muIAqjH8LuonsRuplM8r55YdGhm0hxYjivFWLrQYmgYDiwLl+lt2ee1mRjoN57adBu3JREWnQbrmfxkd3CwMwYL4QeLfRON+b4CP9eMOAmQgfiy5GMiToZcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCoHP2iM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCoHP2iM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F953C4CEEE;
	Thu,  8 May 2025 23:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746747753;
	bh=xkjlkRzXy3gD07TO4pnDWxA5oWDgHXa+wX7fIFSjXqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eCoHP2iMLCyu1EXO6H5ih0kCuk+ZgM727OgswRp34bvzkAIsCtLkkBBe/7UDQdLOx
	 EMX9peaGxT8xWB3vtONkZx8z3GCyqWHfgyUwoiAhkOGlM8yqLZMfsOWGoRpQZIy8Lu
	 GnSd6ESnyHCTALw6ybXLltCeZzuk2m/PducscSSWtK8c3iTlYmXSiNKvMpJqgObmf3
	 C70BMFsMKYkEVTOTDI+7CRO4lJl2IzVbUGhHrt1MRsLgKOLOUKZBOrxYa5VAOVgaBz
	 nCcQv/YPZqiDEUNc6dPdXNHGGhdzOEQZxpdi14UZoJe0v5RsokiuuKkcirTY/DCf11
	 ARH05QrcY2NSQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 10694CE11D4; Thu,  8 May 2025 16:42:33 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 3/3] rcutorture: Remove MAXSMP and CPUMASK_OFFSTACK from TREE01
Date: Thu,  8 May 2025 16:42:30 -0700
Message-Id: <20250508234230.1996554-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <da86a280-f402-499f-a4ba-df626ca4c748@paulmck-laptop>
References: <da86a280-f402-499f-a4ba-df626ca4c748@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Back in the day, rcutorture was about the only thing that tested off-stack
CPU masks, but now any arm64 system with more than 256 CPUs tests it
full time.  In fact, it is necessary to hack the kernel to prevent such
a system from testing off-stack CPU masks.  This means that there is
no longer much point in rcutorture going out of its way to test this.
And given the differences in how CPUMASK_OFFSTACK is enabled in x86 and
arm64, rcutorture would need to go out of its way.

This commit therefore removes CONFIG_CPUMASK_OFFSTACK=y (and the
CONFIG_MAXSMP=y required to enable it on x86) from TREE01.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE01 | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE01 b/tools/testing/selftests/rcutorture/configs/rcu/TREE01
index 8ae41d5f81a3e..54b1600c7eb5f 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE01
@@ -8,8 +8,6 @@ CONFIG_NO_HZ_IDLE=y
 CONFIG_NO_HZ_FULL=n
 CONFIG_RCU_TRACE=y
 CONFIG_HOTPLUG_CPU=y
-CONFIG_MAXSMP=y
-CONFIG_CPUMASK_OFFSTACK=y
 CONFIG_RCU_NOCB_CPU=y
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_RCU_BOOST=n
-- 
2.40.1

