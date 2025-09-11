Received: from fuchsia.ash.relay.mailchannels.net (fuchsia.ash.relay.mailchannels.net [23.83.222.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2649124DD13;
	Thu, 11 Sep 2025 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615106; cv=pass; b=H/Nku2+pQBUXOC0CBFeUYxzcy8imGSk/LRnkZYpIWJzIpj01fWjM02w0OKhTogCs4+M0fXTQplSkEZDN1gsigTd5XHTm/+5kaZAqfxHtSC0NGA0OzXi50PX7j1TVydLUsAFWsQzJpxagHICVT07ZH6ug3u1ed5K7PQM9eLMddaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615106; c=relaxed/simple;
	bh=WwDKNviDEA6uHAFz9Yp0OPtqfD47QY6biWgK1Hnh4aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXYX6yLidzPvNDffIZgGf+xREIlHvKRx0o5QUevfC7tx0nGJzimx+FyGKA0DbgMbWI3yDd6g7DWtsWHeuE6KgmCXV7jdqRPkauLZwuQVB7J3h44ujcbVZu8YDSuW6PYaSs3VjWLfqggYFGh9aXoxjR+u7yuTCsPTe/DePypmkH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=LzY/w8/E; arc=pass smtp.client-ip=23.83.222.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="LzY/w8/E"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 241631A7AC1;
	Thu, 11 Sep 2025 18:18:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a316.dreamhost.com (100-104-249-162.trex-nlb.outbound.svc.cluster.local [100.104.249.162])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8DA4A1A63B1;
	Thu, 11 Sep 2025 18:18:08 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1757614688; a=rsa-sha256;
	cv=none;
	b=kOv0Nixcl2tVIxpa5HUC262/eI5rmNXfnM1/wBYhQIDJ8qFRfsLCwt35FXEZZO3NqCcsb3
	pDYpx7uHzj02mR/TE36un4nG4eeud/3QC04TBlir9R6KnAzMhLDcDr8mSYvfXUIN12qH0h
	4vTbBqj3OBV9w5wdtDIWPZlGbWjxqP7/a2e6Q55fcjrh+05YxIuCuAtDa0hNP6t4ueHeW9
	hOoNcI/4xVUHCZNrIsTm/rnO+R6Z2lSiQqLVD6nwcdk8R1zuXpnAHhj6ccfXYYAIqhxuer
	KL3FL/7xvsNhiy6Agr3k7TvbdVQqrbvlKwQ7soBuUfl5MxIl+tYL/XRWcXckNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1757614688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=WwDKNviDEA6uHAFz9Yp0OPtqfD47QY6biWgK1Hnh4aI=;
	b=CHGNo8do+hWRbVisxMhRXsiBhnmxoD4CE/9RzPpIbGQBObdykqR3eTpi4RLVTsDwarrOZB
	kq9cDpMjLfrD/5TeCVlF4jnv1PUXLmthy+cop7Q8rYb8ntXJOxy6U2qthRiDRPlBugnKrC
	bYsasAPzM3IF9C/Bh28zrm8jgletzhHGxWNh6YwrI7hoz1WH7zcMsAvaRXQAGJmI0LF+iD
	JRr/nZs0qJBKuIfLZPVbRx04znf9bzSzLB1X2w7aNH74icVuPrGafc4BPEmF675j85ObaE
	5Un+1vJ8ixN3570x1F7gvhJSpNSKEVcHqUqocpxGL83XeWj/kMAOify9sIkamQ==
ARC-Authentication-Results: i=1;
	rspamd-7b5fd646f8-2rcbz;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Belong-Imminent: 470f186b1ecd2ef6_1757614688971_2644890682
X-MC-Loop-Signature: 1757614688971:4168443260
X-MC-Ingress-Time: 1757614688971
Received: from pdx1-sub0-mail-a316.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.249.162 (trex/7.1.3);
	Thu, 11 Sep 2025 18:18:08 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a316.dreamhost.com (Postfix) with ESMTPSA id 4cN5QR6tyGzFP;
	Thu, 11 Sep 2025 11:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1757614688;
	bh=WwDKNviDEA6uHAFz9Yp0OPtqfD47QY6biWgK1Hnh4aI=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=LzY/w8/EtH/v5rW2ELrJQ58G9a71xLJBr29V1KCkHA7UB+GzPxwD0+frxeJ5D8fUR
	 QEvFkevHdX++xJIw7FYlhAT+Z+lz2bmp8B7eLHaYbXWK1ginF2+aZwAzTLEPDpp55Z
	 D2ehuNw2S32s700x0/KpdqIqJUzgXmHUdKgKGT29LcqIkOc+4zjH0sszOjJ8yF11hT
	 ped+FkwzgAZ0orZoB+AlBEvgudoPQg8S0u4PVHwKfgY+dnopeqI1+78aTtqvNAJaig
	 j9Imz6KKv7yH2l41YgcuC5AqO712aVS5lwSp7RTJDP0gkCT0oXCzz0dEoB7+Y3borJ
	 CuZWXsRFYDqFw==
Date: Thu, 11 Sep 2025 11:18:05 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: paulmck@kernel.org, josh@joshtriplett.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu/segcblist: Use WRITE_ONCE() for rclp->len
 decrement
Message-ID: <20250911181805.zowj27hon5nazhyp@offworld>
References: <20250911162641.796716-1-kaushlendra.kumar@intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250911162641.796716-1-kaushlendra.kumar@intel.com>
User-Agent: NeoMutt/20220429

On Thu, 11 Sep 2025, Kaushlendra Kumar wrote:

>Use WRITE_ONCE() for rclp->len decrement in rcu_cblist_dequeue() to
>maintain consistency with rcu_cblist_enqueue(), which already uses
>WRITE_ONCE() for rclp->len increment. It maintains consistent access
>patterns to the rclp->len field across both enqueue and dequeue operations.
>
>Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
