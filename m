Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DD417ADEE
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086798; cv=none; b=D3cF29Y40MgpR4R/CT6r4nlWA/qFoadjOXPZtrktiJTsyEotlqX9BflUE1YXF/YNlC3sm96+QXjWaFHo/YDr5g00D/H1GG7ZX1TIOiuwXMPlngz2oc5116ECl6dpjSzyDsK4HilGGegdwY+jnBn+whh7vORqUsmxV/NuvJjOTQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086798; c=relaxed/simple;
	bh=/SzmOJ3LG15vYyGTtMCt8K0n5odmkaPenN5yL3rIqbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/4Un6V2rbXCiG/cyiX39Ffg5zHnDhHuu+dpw2AuR34NJI9bCRKeGk4pAAMBkCCnNinSX8BkbID8BIYceFlkgwT1/c06gYYnUKEpkXz2xhWeXFq9sYcrJgt5jXMGfSBnW9FqIwpG5DITLF0KKtKQ4UsqCy+X14NoUXlsdeId+mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MmZjI8QO; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MmZjI8QO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724086795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q+a59+xckq+FwlxTJgX8Ca3QgkTlwzyh9yPMBQiYgrI=;
	b=MmZjI8QOU4FfHIAlyzVOfn/3g5QIhD3bLcwk0TiPh8g6ONg//O4qEF7D4pzy//8VH1Nj96
	2QB/GWRFzos5QN1Il3lv8jdI3KFdpkINo1nQSD0zMovM0RADTL1Rk3YpsLP1DeLKmv3ef3
	VOLNrutBR1exEtDFKRUjnBJW2M5UBFM=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: rcu@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] rcu: delete lockdep_assert_irqs_enabled() assert in start_poll_synchronize_rcu_common()
Date: Mon, 19 Aug 2024 12:59:31 -0400
Message-ID: <20240819165939.745801-6-kent.overstreet@linux.dev>
In-Reply-To: <20240819165939.745801-1-kent.overstreet@linux.dev>
References: <20240819165939.745801-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

this assertion appears to have been entirely unnecessary

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 kernel/rcu/tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e641cc681901..52f9f0bf1b8e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4119,7 +4119,6 @@ static void start_poll_synchronize_rcu_common(void)
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 
-	lockdep_assert_irqs_enabled();
 	local_irq_save(flags);
 	rdp = this_cpu_ptr(&rcu_data);
 	rnp = rdp->mynode;
-- 
2.45.2

