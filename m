Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2632F5A1B;
	Thu, 18 Sep 2025 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191395; cv=none; b=ioeElDPtZ3an/0vlk/MiM5D7bIlSbnO2a1PuZA/o2+a6tcWf2wzJgRHGCNbdAmoyD8wYnMxGB7RlD8/A6xN3Ve76AwYTFDfuycnqGyAXA33CMeqyDlp9XOaEwQhqWE9AkD7eJU5kROyOGGSmKZV82gorZqEDUjH6WGkKOKusbeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191395; c=relaxed/simple;
	bh=9Jy/9m0bPK9FNxxaGVhSCzbgUZMydSumdbycYxZ2g4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hmsYpYjyZhzFqkPJ6D6ses/PrJHvtH5ov7Wlh+WD3EHTo4Rw4djMKnjbLk6PDbG5jSsseS3TwTxSNdA1ESahrDaAIO4MeudujaPviAhA3F+O+3qGeaxHFWq6TL369zaDXJuJ/4NMGpL4N03ZcgsqgeokUIOWt0XCib4LaWeJwCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4IOeRJd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4IOeRJd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5CEC4CEFB;
	Thu, 18 Sep 2025 10:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191395;
	bh=9Jy/9m0bPK9FNxxaGVhSCzbgUZMydSumdbycYxZ2g4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d4IOeRJd5V9eHONhdRFOfQztG9mW41OYOPzDlhnLQpBacT41BfwHdBY5Efa3W6WVu
	 5+DCpMfUuwMoDVYmiq1UXoP6TzDGTPOzGRJBDW6W1aruZHc97GpxoLvYsPOHXhqlXb
	 ayNYzwBOzXkPbP8II2FzVb9xBkwez3GShiig5EGk+0ap7A9I4+UsN5cfejhChBOAGY
	 aKVQ2mxVvFyNbyNFL1/qkMQJM4pm4wlEymqYcZlul4QWDrsEXGaHG8prT5VGC+27PY
	 8lk/eGPA/2Y41xiufIAud6DWoGCHTf4lGF97P2Z7r1gmhB2GMncUaoihSjxhuY+VMT
	 537F8tDj5gw3w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E15A3CE112C; Thu, 18 Sep 2025 03:29:53 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 09/11] refscale: Use kcalloc() instead of kzalloc()
Date: Thu, 18 Sep 2025 03:29:50 -0700
Message-Id: <20250918102952.2593045-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c0edd79a-f988-432c-b08a-18793b2e15d9@paulmck-laptop>
References: <c0edd79a-f988-432c-b08a-18793b2e15d9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qianfeng Rong <rongqianfeng@vivo.com>

Use kcalloc() in main_func() to gain built-in overflow protection, making
memory allocation safer when calculating allocation size compared to
explicit multiplication.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index df646e0694a8cc..5840fac06feb7d 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -1021,7 +1021,7 @@ static int main_func(void *arg)
 	set_user_nice(current, MAX_NICE);
 
 	VERBOSE_SCALEOUT("main_func task started");
-	result_avg = kzalloc(nruns * sizeof(*result_avg), GFP_KERNEL);
+	result_avg = kcalloc(nruns, sizeof(*result_avg), GFP_KERNEL);
 	buf = kzalloc(800 + 64, GFP_KERNEL);
 	if (!result_avg || !buf) {
 		SCALEOUT_ERRSTRING("out of memory");
-- 
2.40.1

