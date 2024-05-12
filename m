Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673064DA0C
	for <rcu@vger.kernel.org>; Sun, 12 May 2024 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715537315; cv=none; b=UPB8c0W9NFw1U9X5GnHfOsGgFR9ZN8mmsWYjy+ScvCbYT8j5VC0GfAuxfceCP3abT+DWZhgItlD3ndJGzx3gzEwXQVaQ32xm7czPj9fbuDFl9r/+Tgt2PpnkVACAveiesQYw2v3WCIZ0NOv+gf3b7ywSktL8vsGbOXqFE1GljD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715537315; c=relaxed/simple;
	bh=tztii3p8SZMsVIHQ5f8coEr0bKYwPgUvG+i8/bhgAYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRsBv/VPsHczOPbZuh4xtJzOZmol/f2alKQIStCgRxJEiT3AKAMEwvS67NLdRgYM4qr8DVy0uB05T5VvAYQSxCxvWqluxaM1N9UL8mb55tQ/Im5WB6VJzLYL5mmny2r7SDYMFT6y61vyiPj+ehg5cFgwipp7ipMqisX1NxrmoGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JK1Fc4v7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JK1Fc4v7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715537312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tztii3p8SZMsVIHQ5f8coEr0bKYwPgUvG+i8/bhgAYU=;
	b=JK1Fc4v7xYZ6algqY2vLW0S6luFuc0eCrbGIHDiSGy/FnFIVY1sDyxmujjH9kc6IjR5zdW
	Jd5Jd/Yg063gaHfB54OoyMSP9Wl4sKe2s2D6HieGQR7AOYiTl5k8Szr5vr4pFx0vU5tKvF
	wu3j9wp/UXCfeFGttSHxI7EXTCeDTMM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-JsOViRZSMRqC-C8qVT_yjw-1; Sun, 12 May 2024 14:08:25 -0400
X-MC-Unique: JsOViRZSMRqC-C8qVT_yjw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43DAD812296;
	Sun, 12 May 2024 18:08:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.31])
	by smtp.corp.redhat.com (Postfix) with SMTP id 61E542026D6E;
	Sun, 12 May 2024 18:08:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 12 May 2024 20:06:59 +0200 (CEST)
Date: Sun, 12 May 2024 20:06:55 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] rcu/sync: don't read rcu_sync->gp_count lockless
Message-ID: <20240512180655.GE7541@redhat.com>
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com>
 <20240512111948.GC7541@redhat.com>
 <550cf35c-4fb3-4f06-95b2-9206425d74cc@paulmck-laptop>
 <20240512165529.GD7541@redhat.com>
 <bbc3648c-0965-41d1-b245-3a4ca0c9629c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbc3648c-0965-41d1-b245-3a4ca0c9629c@paulmck-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 05/12, Paul E. McKenney wrote:
>
> How about like this?

LGTM ;)

Oleg.

