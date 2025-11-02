Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E2425D1E9;
	Sun,  2 Nov 2025 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762119880; cv=none; b=Bhzu9wXM5CPmKOCrYdu4RwVDPMxrF8j39S7iEcoIeruWPIVbfySKu8Cd9X5Ik8NeragMp0TCJ+JxL3ittvaiWLQlISE/gqndSzv2w5YIB55YXQzgFTtTHG0hJQ7E0YxNDpDXekllg+kWvO8j8Fr1jcq1qM8329MYYTL6zDbNw8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762119880; c=relaxed/simple;
	bh=/aBUUqkdfQzZ+qxvU0KljxF2xX83n5VIIQG+jKSVdFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CYQgeO9N5nv7EiIFd5WAHNTBoMg6789MEPwbQMYh25PmpnQ8fFcL3oCCozptPVES4EqG/h/gvFnqe9KkZvSZSvi8w7vB6wheuLP5uNgo1Gpp4MlXk19oJ1l99QFMYw5/ssnKGDrScZS9DDri3Ymfi7Fxid/x0r+iogo8u1vxThM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1EMTg8l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1EMTg8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D540BC19421;
	Sun,  2 Nov 2025 21:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762119879;
	bh=/aBUUqkdfQzZ+qxvU0KljxF2xX83n5VIIQG+jKSVdFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b1EMTg8lMaI3kCLR83XoezsSTL6mrs8DEEBygsr+3BXTpFSs3kLPOVCML1iT8EATe
	 yp6jClEyIv+rwQmjWwSBVJ9HRudvPCrEznxW2GU59oRlNVAl+jh/bEr+a9xt+qYrfn
	 XQLngiIwZpC8d6xcvz+vQomUMCAVJAWT9MfbsxXLr4AKPv4Ow1YcE6xLaoW9g10aRv
	 LDNFcEStfXlPpZYU7hgqmhY0riU3dQt19CNZbFXKEuoenI+t+7um0bmbbeDQ2GdR1j
	 t2L+urzjZUpI7Q576QcRrTU4m6o86+kgSwn/YAxexaecZX4XFb5y0lkBzfKqwYZUmE
	 IAUiGqdnalnbw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AA4BCCE16DB; Sun,  2 Nov 2025 13:44:37 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 19/19] rcutorture: Remove redundant rcutorture_one_extend() from rcu_torture_one_read()
Date: Sun,  2 Nov 2025 13:44:36 -0800
Message-Id: <20251102214436.3905633-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
References: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit removes a harmless but potentially confusing invocation of
rcutorture_one_extend() within rcu_torture_one_read().  The immediately
preceding call to rcu_torture_one_read_start() already does this cleanup,
and the other call to rcu_torture_one_read_start() already relies on this.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 820c5e5b106b..423c4bddd17c 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2440,10 +2440,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	newstate = rcutorture_extend_mask(rtors.readstate, trsp);
 	WARN_ON_ONCE(newstate & RCUTORTURE_RDR_UPDOWN);
 	rcutorture_one_extend(&rtors.readstate, newstate, trsp, rtors.rtrsp++);
-	if (!rcu_torture_one_read_start(&rtors, trsp, myid)) {
-		rcutorture_one_extend(&rtors.readstate, 0, trsp, rtors.rtrsp);
+	if (!rcu_torture_one_read_start(&rtors, trsp, myid))
 		return false;
-	}
 	rtors.rtrsp = rcutorture_loop_extend(&rtors.readstate, trsp, rtors.rtrsp);
 	rcu_torture_one_read_end(&rtors, trsp);
 	return true;
-- 
2.40.1

