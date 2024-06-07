Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFA514D717
	for <rcu@vger.kernel.org>; Fri,  7 Jun 2024 21:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717795491; cv=none; b=tMyUgSJjC4gDvlyukGEXGw2U8xFxfXNMbLj1x/YSFg7Grt0ovIR4h+2Llg06aL/VY4TLKsvuG//qBx/Rb1ZbNhINUYZfayaGhGt4RelAvmlvBfd27iyf5+dbIBKahVlmcRmWQLnr8bzXrjw0WfF1x4gQn5JMCleaMHWRaLLrydM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717795491; c=relaxed/simple;
	bh=zZDY9HCX0naLs2MBeCNYi6z5vrsIU6UH2T3wDmhVPX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILiQmv6GXQDPTLshdPqYCzFyLfgqrcDcV9aOqjNXeaWDACqEN1T+Ta6o+X59Tmy5U/hDuoMrWD2FkE0xgKqftlN3b9tbghXVcpwdm7MbTrHoa4GnjCP67TUU27zgrm6ZSGygcSo/BE8lNCs8XtdE51T1Rq5a9ySwEUfjq/4yL9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IltnAAI2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IltnAAI2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717795488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zZDY9HCX0naLs2MBeCNYi6z5vrsIU6UH2T3wDmhVPX0=;
	b=IltnAAI2Pc4qYUikjFyI9sJG4fxt/F59ETSAdtij+Co3+dfLE3vthKiktCvEJdPuOyAE7N
	NY/iZo1abm/TefdCp6fgcavqWmPv7kyGW4hPbk32nRW8WXiwA8SqisD13HfTZBTUxETNWs
	s9eh8LHhpm3PWxB3QvnSRHq2n8jxNdg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-ED4dmk5jNxWepKD0nZk-cw-1; Fri,
 07 Jun 2024 17:24:43 -0400
X-MC-Unique: ED4dmk5jNxWepKD0nZk-cw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9AE519560AB;
	Fri,  7 Jun 2024 21:24:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C8E1A1956089;
	Fri,  7 Jun 2024 21:24:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  7 Jun 2024 23:23:09 +0200 (CEST)
Date: Fri, 7 Jun 2024 23:22:59 +0200
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
Message-ID: <20240607212116.GA7258@redhat.com>
References: <20240607062531.GA30954@redhat.com>
 <20240607150443.2096063-1-fuweid89@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607150443.2096063-1-fuweid89@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 06/07, Wei Fu wrote:
>
> Yes. I applied your patch on v5.15.160 and run reproducer for 5 hours.
> I didn't see this issue. Currently, it looks good!. I will continue that test
> on this weekend.

Great, thanks!

> In last reply, you mentioned TIF_NOTIFY_SIGNAL related to busy-wait loop.
> Would you please explain why flag-clear works here?

Sure, I'll write the changelog with the explanation and send the patch on
weekend. If it passes your testing.

But in short this is very simple. zap_pid_ns_processes() clears TIF_SIGPENDING
exactly because we want to avoid the busy-wait loop. But today this is not
enough to make signal_pending() return F, see
include/linux/sched/signal.h:signal_pending().

Thanks,

Oleg.

