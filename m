Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70CB3FB1B
	for <rcu@vger.kernel.org>; Sun, 28 Jul 2024 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722174075; cv=none; b=imGf6jjIb8gxbmNRofRlZM+hAJcPDoX2bIjS+Y0XehbpdUV/ScHbf1snkgCr/YEOZ29hklfE3aFcEOd04FZmysCriF4j89pZ6ftMDQMcMBqi0ylJj1Zjv5A25hXRoo7EhKMAd77sJG6Wwrgg39BA/Wr3PJk85tOMysv5MJyMo5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722174075; c=relaxed/simple;
	bh=wb4+K2jfFCFJm7Q0XiElSQSTmr+5cRu6tJRMaxHh720=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WX2gx18okiEgXbmFoLGdhbn40X0J3aTcUGOG/bT9M9umNu6Sev4Z0nrsdACxyT+CJskjrSmF/vsJPM8pUDDG7ZVDdfQOXonUZFYGBRI1gZ4Zh/vNl7e7/1hFCCfYem801Z+6W8uBJBoHjHvv0xsYCwrqAP6Ab+23VERK06bf+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7sFfT1C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7sFfT1C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722174070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XJS8UcnJOB/j9GcsBVriXkTBQzfHbx96+YQU+0aGTwY=;
	b=X7sFfT1CjTT0Q1lkpWzRVDdZvGpIE5T7phSqNf9uq1zywv91OR7HROIhOe+UY7bpBAFk4m
	L2fYWVchwYhQGI+9AxVTKwzq7z16InRt6VnVIOuW/uYG9JL2go2u+RnBHO24/yqj2iE9gj
	8NaLLAFFSwJitLiLzyLFgzxdxr2UUT8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-KazrzR4NO8y_Q0he9wBSug-1; Sun,
 28 Jul 2024 09:41:06 -0400
X-MC-Unique: KazrzR4NO8y_Q0he9wBSug-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04F3B1955D45;
	Sun, 28 Jul 2024 13:41:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 36239300018D;
	Sun, 28 Jul 2024 13:41:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 28 Jul 2024 15:41:05 +0200 (CEST)
Date: Sun, 28 Jul 2024 15:41:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>, Hillf Danton <hdanton@sina.com>
Cc: paulmck@kernel.org, Christian Brauner <brauner@kernel.org>,
	rcu@vger.kernel.org
Subject: Re: rcu_sync_dtor() warning question
Message-ID: <20240728134101.GA8691@redhat.com>
References: <20240726-ansonsten-piste-c4f04d4909fc@brauner>
 <f4d23fa4-b324-4666-aeb3-ace5c0384e07@paulmck-laptop>
 <CAGudoHHn4bmdR0LetX_bJ1PMtuc6cEYd=hZFutXmqaMG1H+rCg@mail.gmail.com>
 <CAGudoHGznS_Br2gxu=BWsDaCbHmMWRTCmoZDniyFFrDOs9VD5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHGznS_Br2gxu=BWsDaCbHmMWRTCmoZDniyFFrDOs9VD5A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Sorry for late reply.

You do not need my help, I know nothing about fs ;)  but just in case...

On 07/26, Mateusz Guzik wrote:
>
> Welp.
>
> syzbot did the bisect, it's not any of the above, instead:
>
> commit b62e71be2110d8b52bf5faf3c3ed7ca1a0c113a5
> Author: Chao Yu <chao@kernel.org>
> Date:   Sun Apr 23 15:49:15 2023 +0000
>
>     f2fs: support errors=remount-ro|continue|panic mountoption
>
> https://lore.kernel.org/linux-fsdevel/0000000000004ff2dc061e281637@google.com/T/#m90c03813e12e5cdff1eeada8f9ab581d5f039c76
>
> That said, the stuff I mentioned still looks highly suspicious so I
> have to something to investigate regardless.

Did you see the patch from Hillf ?
https://lore.kernel.org/all/20240727011616.2144-1-hdanton@sina.com/
it seems to fix the problem...

Of course I don't understand this patch, but afaics SB_RDONLY can confuse
thaw_super_locked(). If sb_rdonly() is true, thaw_super_locked() assumes
that freeze_super() didn't call sb_wait_write() -> percpu_down_write().

So in this case thaw_super_locked() just clears sb->s_writers.frozen and
goes to the "out_deactivate" label bypassing sb_freeze_unlock().

Oleg.

