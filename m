Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810A744D695;
	Thu,  7 May 2026 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173793; cv=none; b=Ml9Zr754gnufMtuhG1Cyka2kwSpTkA5PsK0VxrvDS7uk7iwBTyJgrI4mRGIHkyeWL+Dg8OyPHaF2qm7JDhnZMB8otbbixmFeJOGgC07uNVzsFo+LWvKAXndV58igt/w/z2S11en9M34T+hbJx+1Pzc8m7LE0aJeJVH/kx/p50vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173793; c=relaxed/simple;
	bh=Ju+wGquknA9vH4d8msEHqAowyOOhmN7jnTkXKOHQ2O0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nHY1kx845AiKtXwQ2RQ7TiseyUVdbx+blnJatBNTiLHnRZwQ2kCjeUUZNwnpm7jF7ROOF26dQQvoOOgPzyhvqsK2+ZOQ51eVcYduTwEMZr98mkfHA84wg0JtWiBJKNE12McfF2mViIAI1j+CKSS90+SHU46/rfYsMaemm1jXbXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjuRflnm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjuRflnm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63830C2BCFD;
	Thu,  7 May 2026 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778173793;
	bh=Ju+wGquknA9vH4d8msEHqAowyOOhmN7jnTkXKOHQ2O0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qjuRflnmp/VOnXPRZ3k8H+pAvRBgs95P7hgSMMn54LR+7xcPXVhK+aG4NxWp+mEke
	 zjXyE8vCh3nt2rzoguaiUC9vCO5D1BIfi4GKP0yBOZW++m8riaYCdptaHtAotY0ejb
	 GUP21KKDZvAsLM+k7CTB8gR/Lab/zZMJDP5j9AoajzERgt1NFxZqICzq/0naewPpoF
	 6zPi6MSZ7U67u5/XHYKrEQ0HdP9Jsio/yKF5XMckW1K9js3j4rdUW8StugzLatYO7q
	 gZvtzp3k1df5/bUMgxvhXQaeJ8QgzdYk4A3bO6/mRe/QtB5zvq0+eGvIWSGClAzta5
	 lz96AcS2v0Qpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B2FB4CE0F1C; Thu,  7 May 2026 10:09:52 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 6/7] rcu: Simplify param_set_next_fqs_jiffies() by applying clamp_val()
Date: Thu,  7 May 2026 10:09:49 -0700
Message-Id: <20260507170950.2040199-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <eeeda48e-03ed-428a-847d-5a0b56508b68@paulmck-laptop>
References: <eeeda48e-03ed-428a-847d-5a0b56508b68@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit replaces a nested ?: sequence with clamp_val().  This does
not reduce the number of lines of code, but it does simplify the line
that it modifies.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e46a5124c3eb88..09f0cef5014c7c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -492,7 +492,7 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
 	int ret = kstrtoul(val, 0, &j);
 
 	if (!ret) {
-		WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : (j ?: 1));
+		WRITE_ONCE(*(ulong *)kp->arg, clamp_val(j, 1, HZ));
 		adjust_jiffies_till_sched_qs();
 	}
 	return ret;
-- 
2.40.1

