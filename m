Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847812C530
	for <rcu@vger.kernel.org>; Fri, 10 May 2024 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349151; cv=none; b=CBeJCcM/LfEoGMliWUx3ZBvPWucW3xj/1sIB1UmprULhjhWfIZL8IHuDNfJ2NwuSd/hzJY4Gl2hTWqSR7KKGr4QF5q7I74+UwjF/mNK+X9lhk28G62gQlAEbJSSY6QDd5aZbR0R2w0FpB/Ka48wlYZQPVRk0ZTfk9YjpY+m3uWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349151; c=relaxed/simple;
	bh=8WQKOarhlV+n52hs+H1jjdRUk7esOoGpFkk8kHxEvRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFCt9NHNhRyiLNQZ+18izh99y/znLVc6FuGChC1iC/UbZ18Dw4M52Xc49uqQE0XGoA8dyt+/uPHWGe+I7d/ckwZihb0pyxD/jZ5rST24+i7V+WLrgxxiphNIjyZTSupTxZmr9EOxpPg9C2NiJ2vqizP3O6NQW0Dfol2gGXxYsNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HLbacjPM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLbacjPM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715349149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8WQKOarhlV+n52hs+H1jjdRUk7esOoGpFkk8kHxEvRo=;
	b=HLbacjPMQqrnFIZLRGVmCsiGs4JFVWCSX6ukQc8VfC891AueadFjDqu1OSzagAKJUrrdDR
	GgXhnCZY03z85vMl9wfYINP89HzElPKhLsZXf/GzlyJ6bVCAs44PEdaoZIersWqOZt5r54
	9GQsQKC0qqmDouRTP9L/f7Emenok6s0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-AV0Th6AeOAm7wyofLfpVvg-1; Fri, 10 May 2024 09:52:26 -0400
X-MC-Unique: AV0Th6AeOAm7wyofLfpVvg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CA13857A81;
	Fri, 10 May 2024 13:52:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.196])
	by smtp.corp.redhat.com (Postfix) with SMTP id 22B35CF5E1B;
	Fri, 10 May 2024 13:52:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 10 May 2024 15:51:00 +0200 (CEST)
Date: Fri, 10 May 2024 15:50:57 +0200
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
Subject: Re: [PATCH 25/48] rcu: Mark writes to rcu_sync ->gp_count field
Message-ID: <20240510135057.GC24764@redhat.com>
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com>
 <ZjpAsYJIfzYSKgdA@redhat.com>
 <4c9e89b5-c981-4809-8bc2-247563ce04e9@paulmck-laptop>
 <20240510131849.GB24764@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510131849.GB24764@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 05/10, Oleg Nesterov wrote:
>
> On 05/07, Paul E. McKenney wrote:
> >
> > By the stricter data-race rules used in RCU code [1],
> ...
> > [1] https://docs.google.com/document/d/1FwZaXSg3A55ivVoWffA9iMuhJ3_Gmj_E494dLYjjyLQ/edit?usp=sharing
>
> I am getting more and more confused...
>
> Does this mean that KCSAN/etc treats the files in kernel/rcu/
> differently than the "Rest of Kernel"? Or what?
>
> And how is it enforced?

I can only find the strnstr(buf, "rcu") checks in skip_report(),
but they only cover the KCSAN_REPORT_VALUE_CHANGE_ONLY case...

Oleg.

