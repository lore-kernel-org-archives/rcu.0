Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDADE242262;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058876; cv=none; b=axlm3YvztmFBzxD7CPoZwI6On2aM3aCUb67KnkikfaRpW8R9zHVoDpkUtce8z+NX4dhuOjIEHAfYCtyQPV5NY25YY1sMkeXAJFFBIZI5lqbI88hy1rcKTGwb3oKaEIxYABY0FeNT6rK4NlaafK+k2BF0bfOrxcngXZ4YNbZ/cWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058876; c=relaxed/simple;
	bh=yWsk7wp4oUog2d6FUYqdT4GsYlXixBLX6B5MYwCKg90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lye1dSOwr2EZX73S4nLa/xZ/PoKpwqTPW9zf8nPN+X+B2gYxPoZWM5FAyLeBwNwWgATZ6+/Q+3vg4iSDQi0u1U7Obc9wMH+4JEq2tDu/GzDvW6pf055daXxEMBggfZVfDVA+m7iocje3NSdp0PVwIudvhu7rfIea9YdgRbPQJG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMKmZroF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMKmZroF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9255DC4CEEA;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058875;
	bh=yWsk7wp4oUog2d6FUYqdT4GsYlXixBLX6B5MYwCKg90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uMKmZroFvnwFlWiqce+qznInE5DZiUqI9CqnIBJnT9aIxcaey3QAZU8Eaj/wWwnKf
	 4/ojdbR1un3Lyanx8wEOF+1YODqHScSteieQiDhPY7MdpBRisInzqHyaWFRSl3yVj3
	 nGdF+D6mvLb4+lClmkWpqtGBZDSDgEMKDQ5o/v75iO5UHn90NoMbHT2YtM8ik9Z69E
	 +Z5PlFu6JnLhLstHFJXWVzaUPvKArdK/sOVTLd244rSKPWxVdcWkwMDIDIQjnh2ru3
	 1vsyPQ2baNTtmFCz6uE38HtdP6DQDyE8wFLGTdIABdevcF1XIRePs4n3r9dvQ3UlaA
	 BA+WqgWDZqwUg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A7E0ECE37DD; Thu, 16 Jan 2025 12:21:14 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 16/17] rcutorture:  Make scenario SRCU-P use srcu_read_lock_fast()
Date: Thu, 16 Jan 2025 12:21:11 -0800
Message-Id: <20250116202112.3783327-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
References: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit causes the rcutorture SRCU-P scenario use the
srcu_read_lock_fast() and srcu_read_unlock_fast() functions.  This will
cause these two functions to be regularly tested by several developers
(myself included), for example, those who use torture.sh as an RCU
acceptance test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot
index 2db39f298d182..fb61703690cb3 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot
@@ -2,3 +2,4 @@ rcutorture.torture_type=srcud
 rcupdate.rcu_self_test=1
 rcutorture.fwd_progress=3
 srcutree.big_cpu_lim=5
+rcutorture.reader_flavor=0x8
-- 
2.40.1

