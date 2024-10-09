Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CCD1E1A07;
	Wed,  9 Oct 2024 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496976; cv=none; b=JNM2MRTD27o5XS83HtCCZCy9PWpY0L8IORDq41EomdqSdgC6eqcA5miIuFqT/eQctwiqlMQMkf/IGO8oOMh0a69qGzWbvGqegTrPX5jzHQfPjD1EDoQS5OZocXGjEdwWFZ7XXZoG6ut92FAonZsmUOaL9L5ugcQAqfPfTKKqHGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496976; c=relaxed/simple;
	bh=oFO/7qMuKGNQ5tH6biPfmQ7RINtkm2aVrrRixQVm2/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t7BJDail+b25Olaw4Mx9br4R09kmSKdZK9zxzP3CDF0sbGzholqA4eCJfZ/Cg8LAi2zFZeZWnmT2kWAWDvlxWBGn5f1DgL5c4f7Ur3nheaL82Iguj5gnwbByphciQ+IlkL2ktfF1gWd0NcEzhwpxNPnc9nIFeyFDJHOW6UnGJHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIK/bB2Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIK/bB2Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E632C4CED2;
	Wed,  9 Oct 2024 18:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728496976;
	bh=oFO/7qMuKGNQ5tH6biPfmQ7RINtkm2aVrrRixQVm2/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nIK/bB2QCU64nmffD0sqhTZlfydtXU1yOXRCqwI6I/aT1CXu4TX7AXx/e8Nv3jshm
	 whwpQ66RfG6wCRT1RbR0j7ZOJ1AVLxhk6eIuBjTilVrJzWDAETAYAvlz097PAbeopv
	 K5Qw/Wx/5qXHCvl1NBSAKovpp8MjHMQXFvTNZdfzGZib5XRlgJppWNPyz2jI1TJdhp
	 ptT0pIb3dygH+SZmefnjROwsDNzXrhgYAlqpHGyOkyiklvSoNOXilZ4ZTekiEYpGev
	 IDS4yolkqQs7MXmD6MBi5GhnjkMNMAFWk4PxytelgiHLswC/qdUAbpgWvv/XeuFxWG
	 wQVM0KMxchtsA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CA5CECE0BB1; Wed,  9 Oct 2024 11:02:55 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/5] refscale: Correct affinity check
Date: Wed,  9 Oct 2024 11:02:51 -0700
Message-Id: <20241009180253.777965-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <51cccc37-5139-497c-92e3-6a20e17939a1@paulmck-laptop>
References: <51cccc37-5139-497c-92e3-6a20e17939a1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current affinity check works fine until there are more reader
processes than CPUs, at which point the affinity check is looking for
non-existent CPUs.  This commit therefore applies the same modulus to
the check as is present in the set_cpus_allowed_ptr() call.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 639d1cfc657b2..af32331ef645a 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -863,7 +863,7 @@ ref_scale_reader(void *arg)
 		goto end;
 
 	// Make sure that the CPU is affinitized appropriately during testing.
-	WARN_ON_ONCE(raw_smp_processor_id() != me);
+	WARN_ON_ONCE(raw_smp_processor_id() != me % nr_cpu_ids);
 
 	WRITE_ONCE(rt->start_reader, 0);
 	if (!atomic_dec_return(&n_started))
-- 
2.40.1

