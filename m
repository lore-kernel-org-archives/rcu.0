Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E4C199923
	for <rcu@vger.kernel.org>; Fri, 30 Aug 2024 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015918; cv=none; b=YPgEhbLYv1Jz+NFOf9rYGoLkrj+jSu6L8AuNyFgRdpTP9fMNZIjFetEDbYOGFmX7J303/RzOQXzWyOE2vhCorBt0eKGaxup5X9v1SUl6hK/ch0UaCIubyz50MXophPEvtNwNMWGJcghLkPtbhQiIx+Df/rUIP2KEvfpPiX34MD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015918; c=relaxed/simple;
	bh=kOIpmlYJb8ft6Y2rN58XGcZtgztFV91lYJqhTSPV0c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VN2puHB5zeUCJtSzr1TRtg3r7iRbXAb/2bI7PcHgFVIfLbd6etv+xFlM+nDyfGu1beMYy5177vh9kMwiXEgh0RkpG/PlRjKudZgnEqKwTrfZ/4/xzOg9uOv/OBgSDAA5xkx3KxIFDvhc8Q1p/ibIa0KtpBAoA5lYM5q1HbLcUgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ya4vmu2O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ya4vmu2O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725015916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l0tSha6adNMlOrHuzQyVeK84z60qmOVbtCpMu1nyGv4=;
	b=Ya4vmu2O4FL8mAnPAY6QfAi4k0kG7tVEdqukb56MDW+gCYPZxF/Oaxw8PMaCOmKfhRaj13
	+lqLPW0HS4OIm8WOyOEh5GY3XtxzQKL5krNBsx/8TG462x1S6xqFcXzLr5PEjvDsGn2u3s
	x1JK9MxGrhx+JiMcDrE6ltqee4dKNXg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-tzY--79qN_6mAMQY2I00NQ-1; Fri,
 30 Aug 2024 07:05:13 -0400
X-MC-Unique: tzY--79qN_6mAMQY2I00NQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 841861955D54;
	Fri, 30 Aug 2024 11:05:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.45])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D418B19560A3;
	Fri, 30 Aug 2024 11:05:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id B3E191800D40; Fri, 30 Aug 2024 13:05:08 +0200 (CEST)
Date: Fri, 30 Aug 2024 13:05:08 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Yiwei Zhang <zzyiwei@google.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that
 support self-snoop
Message-ID: <vuwlkftomgsnzsywjyxw6rcnycg3bve3o53svvxg3vd6xpok7o@k4ktmx5tqtmz>
References: <20240309010929.1403984-1-seanjc@google.com>
 <20240309010929.1403984-6-seanjc@google.com>
 <877cbyuzdn.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cbyuzdn.fsf@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

> Necroposting!
> 
> Turns out that this change broke "bochs-display" driver in QEMU even
> when the guest is modern (don't ask me 'who the hell uses bochs for
> modern guests', it was basically a configuration error :-). E.g:

qemu stdvga (the default display device) is affected too.

bochs-display is effectively stdvga minus the vga compatibility: no text
mode, no silly planar video modes.  Only linear framebuffers in xrgb
format are supported.

Both devices are handled by the bochs drm driver.

> The CPU where this reproduces is fairly modern too (Intel(R) Xeon(R)
> Silver 4410Y, Sapphire Rapids). I wish I could give additional details
> to what exactly happens in the guest but I can't find anything useful in
> the logs ("WARNING: Application 'org.gnome.Shell.desktop' killed by
> signal 9") and I know too little (nothing?) about how modern Linux
> graphics stack is organized :-( Cc: Gerd just in case.

The device has an (purely virtual) pci memory bar for video memory.
The drm driver allocates buffer objects in this video memory.  They
are either used by the kernel directly (fbcon case, which works fine)
or mapped into userspace so the wayland / X11 display server can
software-render into the buffer (which breaks).

take care,
  Gerd

