Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E51865C
	for <rcu@vger.kernel.org>; Sun, 12 May 2024 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715512885; cv=none; b=mn47zO/hWvWnHzHH/iMsDjP4kcRDlP1OrNxSMm1afJaN31yo46HMP4rWV47wZaRQO3OVoofgi3cQb6b2HaEWgM/0vzg4z2ib1jenern3Y+sOesJeEVqF8uMKjv1fPxQBeGTs6g8w3aAmhCFKJCs0CfpIs4hl6ebVD5msVO7INZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715512885; c=relaxed/simple;
	bh=oi4tXNBwdMWHpwao/JpAnY5vRdxyZ7Hdoa62eDg5XYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQIBnCeq5vFcdJP8kYF+6KGi5ekrKvaoJNOJ94Bwre8Ie7mqHOef7dKMhl9E6HP0P+6o06ALYyWmn0gpEK4wQ7g9ShDrDsVyOd7KfevkiFdPMaGP4kTg5OWd36R71JDTvvSKKgTLQhpz8jhw3lY02AOtWK6vx9oyEJu/tYAnv2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KKt95cud; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKt95cud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715512882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WUR0UZti1lE2smopgq2+r8fhUDTBOIVHzU3OV21Q2YA=;
	b=KKt95cudAiWvOGFBV9EQ8XJuvQJRimL9a7UMEzcTkCK5IGiQybAOjdNAIyBM41C2l4v47l
	B+7LxpvmKi04g9+UEirES8ODdurogTLmjtrvYPPz2H1SvUhP48z0nj88gFot/BSDAHzV8r
	JHXCb2Ncrkxrf7zqZo+P3AX0104dBtc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-_QPEU4ZWM6-50bohXRkLWQ-1; Sun,
 12 May 2024 07:21:18 -0400
X-MC-Unique: _QPEU4ZWM6-50bohXRkLWQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E278380008B;
	Sun, 12 May 2024 11:21:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.31])
	by smtp.corp.redhat.com (Postfix) with SMTP id 4BB182026D68;
	Sun, 12 May 2024 11:21:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 12 May 2024 13:19:52 +0200 (CEST)
Date: Sun, 12 May 2024 13:19:48 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] rcu/sync: don't read rcu_sync->gp_count lockless
Message-ID: <20240512111948.GC7541@redhat.com>
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507093530.3043-26-urezki@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

rcu_sync->gp_count is updated under the protection of ->rss_lock but read
locklessly by the WARN_ON() checks, and KCSAN noted the data race.

Move these WARN_ON_ONCE()'s under the lock and remove the no longer needed
READ_ONCE().

Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/rcu/sync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index 86df878a2fee..b50fde082198 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -152,9 +152,9 @@ void rcu_sync_enter(struct rcu_sync *rsp)
 void rcu_sync_exit(struct rcu_sync *rsp)
 {
 	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_IDLE);
-	WARN_ON_ONCE(READ_ONCE(rsp->gp_count) == 0);
 
 	spin_lock_irq(&rsp->rss_lock);
+	WARN_ON_ONCE(rsp->gp_count == 0);
 	if (!--rsp->gp_count) {
 		if (rsp->gp_state == GP_PASSED) {
 			WRITE_ONCE(rsp->gp_state, GP_EXIT);
@@ -174,10 +174,10 @@ void rcu_sync_dtor(struct rcu_sync *rsp)
 {
 	int gp_state;
 
-	WARN_ON_ONCE(READ_ONCE(rsp->gp_count));
 	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_PASSED);
 
 	spin_lock_irq(&rsp->rss_lock);
+	WARN_ON_ONCE(rsp->gp_count != 0);
 	if (rsp->gp_state == GP_REPLAY)
 		WRITE_ONCE(rsp->gp_state, GP_EXIT);
 	gp_state = rsp->gp_state;
-- 
2.25.1.362.g51ebf55


