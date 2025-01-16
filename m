Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00CE244F82;
	Thu, 16 Jan 2025 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737059076; cv=none; b=B2V+wpA7sg134tzSWc5yw3S7SkwouPlMvQrn3QFW4nArQ3AeIsRMUU+2QiA/CYcRQ9+dx2WXjop87MGAXJzMTJg+YjeEz9UqsoSeD0AEIo8LxUS8LGyYYonSsCAGIxFqI6nZOUsDc2R4pVEC2lynyNZ8qXl9w382IodlJ7XGdOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737059076; c=relaxed/simple;
	bh=KB7ffITFRNm9svQKvwkYB6dRr1WT4/QwQRwGRBNJU48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XJl298YgjrijBjdYpkRrsQk6S5EuU3LHg9Gsmn3fsXMH9pg5mgDw1w2Ct5FFtAmaRXnr56s6O0fXaYn0+BLJ6toVXQ0SI0pXzNISghV5rXpyUe49SNkltFqn+5dFfe8Lq5UZ2z05AQmmZbHilDtS5FPBxrYtKWe6ExMzH0mVN6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6Yz7bvw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6Yz7bvw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E51C4CEEB;
	Thu, 16 Jan 2025 20:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737059076;
	bh=KB7ffITFRNm9svQKvwkYB6dRr1WT4/QwQRwGRBNJU48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u6Yz7bvwgj4h+cU2O5vnLFA5gXHAtfnj12w47WYEPljgsxmbIV8gGxT7qKy24l6iK
	 OmkftegDs8RlTmb1LBMXyRQcx7XteFj0XAzP8mVDLdXWHaEQUggRYgTlYAqTkbmanX
	 ZAoL+BGGSmhYh9m4ONd6kcGNg0m8VK4mV0Us1UrsHphEkb0WVd1cuHBqyFjkJUE3hE
	 vgIUxH7N7JMt8UYXIYxSMkqvZmIyl5dQsimOiJtdCaBkaJMtOIKr0LSKJ5mskNYNZX
	 RWHokevHFKYAy6iyFwpw/dISGi5avAI0ZSoRu3U79oroj0sbV/wm3uZH/kxHFu9HRf
	 cObmnpGNtblfg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B349DCE37D5; Thu, 16 Jan 2025 12:24:35 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 09/11] rcutorture: Complain when invalid SRCU reader_flavor is specified
Date: Thu, 16 Jan 2025 12:24:32 -0800
Message-Id: <20250116202434.3783613-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c4864e07-93b8-4bc9-80fd-62b00a64e329@paulmck-laptop>
References: <c4864e07-93b8-4bc9-80fd-62b00a64e329@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, rcutorture ignores reader_flavor bits that are not in the
SRCU_READ_FLAVOR_ALL bitmask, which could confuse rcutorture users into
believing buggy patches had been fully tested.  This commit therefore
produces a splat in this case.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 2e6e8664e4038..36bc8d1332d43 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -690,6 +690,8 @@ static int srcu_torture_read_lock(void)
 	struct srcu_ctr __percpu *scp;
 	int ret = 0;
 
+	WARN_ON_ONCE(reader_flavor & ~SRCU_READ_FLAVOR_ALL);
+
 	if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) || !(reader_flavor & SRCU_READ_FLAVOR_ALL)) {
 		idx = srcu_read_lock(srcu_ctlp);
 		WARN_ON_ONCE(idx & ~0x1);
-- 
2.40.1

