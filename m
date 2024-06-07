Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441201CABF
	for <rcu@vger.kernel.org>; Fri,  7 Jun 2024 06:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717741643; cv=none; b=EEu1uKQVdUv/iTtL1cyvEvEX385mxttFXS1+CLVkkd8d6FQ3r7Vov4znztWAyk6f0bEUF3NkxtFZibxXsXby1aoQ2BGvwpDu34mQab4ZCwooaqfGTW/50+ZLp5dlhqqyfJfjBG00v4ltI2mR+HzH2zB/Qp9Yxz5TNlshuRnDqnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717741643; c=relaxed/simple;
	bh=7l34DuoF32Wc8jfFzmRvwBR/sGpFa36t+jZFou8s5R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEsWagGFLNj8K86aJI+pONUuCoCLxLmh8eYw+mGowpCqIAqcHOX9VARyqBxfem3DVGKeUjjo/2fj9hCLBWU1EX/q20YDQNSid1DhdKtgWqknHlTny9jlWgDOZeh1GRQ+rCf3QslCsrgB74sMGGDlLrvi2lPgk8UiV91xL4YKWyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NP8gphYN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NP8gphYN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717741641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7l34DuoF32Wc8jfFzmRvwBR/sGpFa36t+jZFou8s5R8=;
	b=NP8gphYNgYz5BHqNiqUNfBdF8fRkT97WsxBtkoy91S7pYLcDyLJY0JHToPrIa0GdX9ezvD
	c12YE2k3NVkNRbHp+yywYTTrobbLb/H7vZv1Y8X0ogtjTLPq8Sl5fQNAv1jd5yxS2zomI9
	/zlR84RZOTtdxKcWkQTyNA5ZgaxBjEw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-toa5buPyNVOv6pbV-lg_ng-1; Fri,
 07 Jun 2024 02:27:15 -0400
X-MC-Unique: toa5buPyNVOv6pbV-lg_ng-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E06D193586D;
	Fri,  7 Jun 2024 06:27:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.200])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2AC4D1955F14;
	Fri,  7 Jun 2024 06:27:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  7 Jun 2024 08:25:41 +0200 (CEST)
Date: Fri, 7 Jun 2024 08:25:31 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Wei Fu <fuweid89@gmail.com>
Cc: Sudhanva.Huruli@microsoft.com, akpm@linux-foundation.org,
	apais@linux.microsoft.com, axboe@kernel.dk, boqun.feng@gmail.com,
	brauner@kernel.org, ebiederm@xmission.com, frederic@kernel.org,
	j.granados@samsung.com, jiangshanlai@gmail.com,
	joel@joelfernandes.org, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	michael.christie@oracle.com, mjguzik@gmail.com,
	neeraj.upadhyay@kernel.org, paulmck@kernel.org,
	qiang.zhang1211@gmail.com, rachelmenge@linux.microsoft.com,
	rcu@vger.kernel.org, rostedt@goodmis.org, weifu@microsoft.com
Subject: Re: [RCU] zombie task hung in synchronize_rcu_expedited
Message-ID: <20240607062531.GA30954@redhat.com>
References: <20240606172848.GC22450@redhat.com>
 <20240607030219.2990306-1-fuweid89@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607030219.2990306-1-fuweid89@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Thanks for this info,

On 06/07, Wei Fu wrote:
>
> All the kernels disable CONFIG_PREEMPT and PREEMPT_RCU.

Ah, this can explain both soft-lockup and synchronize_rcu() hang. If my theory
is correct.

Can you try the patch I sent?

Oleg.

