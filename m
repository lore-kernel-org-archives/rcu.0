Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB14205E1E;
	Tue, 12 Nov 2024 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731375105; cv=none; b=qW6p8McxPMbd7JsjMIrHq7bzvdcQrFOgYX6CZj7dSPHs5F7Q+P4hmE+UQR9SRXabLWVJMy+Q2s/gomJN8+lePyor1OyEr50/KttLZsFiNvoL0v0Z3hqs+m9mjrYnro9EYdOttQWyWrdTPZd2sDv1tY0mDutKphfSadIDmZlaRPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731375105; c=relaxed/simple;
	bh=MVgOKsZ5cymmfkHb8KBHOc8ZHTR30pecMj78iSO0C7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X/WrDVVmFMbnJbASToqrWLzevlHxLNRLmd6qrf76sp8Amm5rbI5P/rIc/EspQ1gdZAQqEsf1PSRSzzr6vHQQuYlE2m85Y5u4CKV3Gdk7YCWWlQRIY4vEoUF9bYlLwl4Nqiwy+fMOVyNQaitEwtsM61tPGv0NY06JWTg6RVteUSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtG8i4eM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtG8i4eM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2647FC4CED0;
	Tue, 12 Nov 2024 01:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731375105;
	bh=MVgOKsZ5cymmfkHb8KBHOc8ZHTR30pecMj78iSO0C7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DtG8i4eM3UsNa3nG+ZzccEsiQAuu10OYc8P+mGfUYpqZilqfXNMy6JvlDP7VNKKqb
	 mys0kK+xz1N+kg/CpN9MckbCzBr0vMhnCurpbCHnas/mxIJFtiYo21ZM5gGhR7Vr/q
	 3LCz5qRSP6u7/1qXO+bn+eGKdwPb5m9c6zdx+/i6jGSwgR1qBU9MnaWY3GqcsZPbyH
	 /FBAJhRE6Wnt1kJMVrK+ISN5C5pUYcm2/BX3q1eqDGAFXSRaim0FfJ1nP4+8+UjEOC
	 vu24WCAr0/5NRpbbParGt7UbAkQqzVxF9keAn6zieqfHVddtc+RhnbR4S3XsCHE3rv
	 UzPSF5nZ/aZVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BA84FCE0BA3; Mon, 11 Nov 2024 17:31:44 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	frederic@kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH rcu 1/3] srcu: Remove smp_mb() from srcu_read_unlock_lite()
Date: Mon, 11 Nov 2024 17:31:41 -0800
Message-Id: <20241112013143.1926484-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bb96e032-4f7d-41bf-a675-81350dca8d0a@paulmck-laptop>
References: <bb96e032-4f7d-41bf-a675-81350dca8d0a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The srcu_read_unlock_lite() function invokes __srcu_read_unlock() instead
of __srcu_read_unlock_lite(), which means that it is doing an unnecessary
smp_mb().  This is harmless other than the performance degradation.

This commit therefore switches to __srcu_read_unlock_lite().

Reported-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Closes: https://lore.kernel.org/all/d07e8f4a-d5ff-4c8e-8e61-50db285c57e9@amd.com/
Fixes: c0f08d6b5a61 ("srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/srcu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 512a8c54ba5ba..fff6265818d4f 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -373,7 +373,7 @@ static inline void srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
 	WARN_ON_ONCE(idx & ~0x1);
 	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
 	srcu_lock_release(&ssp->dep_map);
-	__srcu_read_unlock(ssp, idx);
+	__srcu_read_unlock_lite(ssp, idx);
 }
 
 /**
-- 
2.40.1

