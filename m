Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC5114D280;
	Tue,  4 Jun 2024 22:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539837; cv=none; b=MhYZh79uB3Aq+I3VJpjNlXFCuCblwveLPk634VH8FypZi5zk9GmWhCJIeQtdsYk2dg1iQVyd8vk68pX0IZsKuVVeQl+pLrERETt1s53O5Ybd2D7UnT5Q8VxLCzLvVQ7FegzH/M+vHROySZnOIjUddfEv89qiXgYbsCqVcDO4wt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539837; c=relaxed/simple;
	bh=98bpyMc4kjv6NZYaNOfRLHxirnUo9+sqZwi21lujIj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cyICS69W/2B/O4hcPIte7Mkax0QQrIrLpSuzt9YzMRauALqKICQmMpxBpEN4oG972FTkFkTkg2QbkUoHgHoi9GgTXQLFFndVmociZVU3OUzAyM6n9MYp+zzE+iCfeEUbeOKQFsQ3Jet24ZGadSKJBYKlbTwLy6cajeDK0T2d7Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPKa69by; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPKa69by"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CB4C4AF11;
	Tue,  4 Jun 2024 22:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539837;
	bh=98bpyMc4kjv6NZYaNOfRLHxirnUo9+sqZwi21lujIj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPKa69bymMxvmWPand6Ih37w5YpXlIXfzKLK4yX5nhY7ZolasnPQkBO43EibtqMV2
	 npkcNgtpaSoOsnX2obVG3/bdM25lPWiz5hwt5pqsAZOrKBxEk8QGwbAMSg7KVqrpxn
	 iEilfCvS4lxZB1TEx8luUUNX+oY5u7qBAI9g+GI0gBsoz0B1c1n9kkyDMf5ELlngPb
	 cNyE7gLjuCf9kPGG59+rHBQfjZmiJLWlC0z1fX099opPwaBpyGD2FEA46U/cpyl/ce
	 ouGQ1OvTyT3ZBph2tTd6h0qkeDCU6a7Yf13IjgET6qDyPzAKaaQECkZW255ThOb7rR
	 mph7GHqzTGE5w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 698DECE3F32; Tue,  4 Jun 2024 15:23:56 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH rcu 7/9] MAINTAINERS: Add Uladzislau Rezki as RCU maintainer
Date: Tue,  4 Jun 2024 15:23:53 -0700
Message-Id: <20240604222355.2370768-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bfe..3f2047082073f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18868,6 +18868,7 @@ M:	Neeraj Upadhyay <neeraj.upadhyay@kernel.org> (kernel/rcu/tasks.h)
 M:	Joel Fernandes <joel@joelfernandes.org>
 M:	Josh Triplett <josh@joshtriplett.org>
 M:	Boqun Feng <boqun.feng@gmail.com>
+M:	Uladzislau Rezki <urezki@gmail.com>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 R:	Lai Jiangshan <jiangshanlai@gmail.com>
-- 
2.40.1

