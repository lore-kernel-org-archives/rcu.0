Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D341B14FC;
	Thu, 20 Jun 2024 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899903; cv=none; b=auW8lwsJsOOpjtoylAGRXQuMp0H3H5UL6MY8WtlhRyN0Ls7vKn+IVlnpznvJagNgvMuSGHNshsWV8cS+6zefIui2RvT0kYDFOmz22fumyRa0WUWNZX+zPxMA2C1mQfeBIDF1g+JnztnB48bLhepgE+NNfuaKyedVXy3nBeLvomo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899903; c=relaxed/simple;
	bh=euBix38Jm8G67OEkavVkD0JdJFe2SQTY6LiqJ3ZgmuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d1NEUNNQJbTmIF3GMPZ4yzhRBX066eJEfq5VYc24W6mNxA49kSQOHuf/oTEbrajvQLFUBFk5u51OC+BGGXHgIIBUDZfdOHm2ccr6RaXTei6aM4m+FEnrj1d4/R9i/Y2HvrWxs7WLbpsBw31E7/OZ2IBVxLH5EY6GMFh9etmEE7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mX9S0qMX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mX9S0qMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93576C2BD10;
	Thu, 20 Jun 2024 16:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718899903;
	bh=euBix38Jm8G67OEkavVkD0JdJFe2SQTY6LiqJ3ZgmuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mX9S0qMXW3h9nUgO7SpvxqsaGe16oRmI0FE4yUbKvVlBY8rQM9zDOl/5tOjJQPWpI
	 52lLH8ax402ypYCC2Ngx3oN0YG3tyJ0k7Z0WM38FVjGVChSDHOzLjI94obCDY5NmMW
	 H86JHs4s3fbl1gr4d5qR8QpzWVZXHAp6xFV2rgVIxHws5lADosRoUp3devUBbPgf7j
	 nM8Nxc8RacqddjHY+SK7FdzEFH5C7jOSXqALSRwp/G4zEcAIye9ft/kDZB5CqvawtI
	 vRUXwG13gVjagkpuCFIFqhaXNXbRT/tQ0nD4D4Vz2r3x/T+5rfFW84d5DpkJlVv6Wk
	 yKg6dxOaiqlcA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4D632CE0B67; Thu, 20 Jun 2024 09:11:43 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH rcu 1/3] srcu: Add NUM_ACTIVE_SRCU_POLL_OLDSTATE
Date: Thu, 20 Jun 2024 09:11:40 -0700
Message-Id: <20240620161142.2057652-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8ec14282-a768-49eb-b870-c2ee51e91f8b@paulmck-laptop>
References: <8ec14282-a768-49eb-b870-c2ee51e91f8b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds NUM_ACTIVE_SRCU_POLL_OLDSTATE, which gives the maximum
number of distinct return values from get_state_synchronize_rcu()
that can, at a given point in time, correspond to not-completed SRCU
grace periods.

Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
Closes: https://lore.kernel.org/all/irycqy4sinjdgm2hkyix2bffunpcmuwgeufsx6nlljvqme3wiu@ify3zdnrmzph/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 236610e4a8fa5..f664cba7a80c2 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -61,6 +61,10 @@ unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp);
 unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp);
 bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie);
 
+// Maximum number of unsigned long values corresponding to
+// not-yet-completed SRCU grace periods.
+#define NUM_ACTIVE_SRCU_POLL_OLDSTATE 2
+
 #ifdef CONFIG_NEED_SRCU_NMI_SAFE
 int __srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp);
 void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx) __releases(ssp);
-- 
2.40.1

