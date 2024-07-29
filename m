Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D9C84DFE
	for <rcu@vger.kernel.org>; Mon, 29 Jul 2024 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243784; cv=none; b=bgkTIrsZEcc41c4WMuwiSD/XCevhj9S3a29uPtfrxBcxVgc1oRYHf93SZjWDhhiO0jC5XnfhaZChjh8LRZtejer5sNRrhS6rE5lA8QSLldNb5nXsK60YazdBfEEJC6COfBARzKpb33WWziPptMrT8fdFtHJG/7fDiBUbEx2CYrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243784; c=relaxed/simple;
	bh=800qYSGSMNQ3LHuAs6sM3rxDUIN/JKq9quuYxlASpSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myblO2McqNHEUaaQklU+dQT70Eyotp5AN+p0LOAvnh4KRIEDUGx16mYbOYyvXhnjZ1OSN8Jz4cb+18fnmdq98L+KvFe7Ha/O2BG1C7Adt0PZnaT2WO+6hWNhKZjFB9L9+yjWHeF82uC3BRyPNZzL9eQ6vqR2dM9l/CqzR2/2yis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cnwIW2/d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnwIW2/d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722243781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=800qYSGSMNQ3LHuAs6sM3rxDUIN/JKq9quuYxlASpSw=;
	b=cnwIW2/dfcr0aB6ASDkEfks/Rr8u8VnNDUNc1Fn2anC6bkhr8QcjGCxwSXySnNMydylBTD
	CJq3Hj3THfNhPmt9Pf7jbx2sO3tBJuHUYX4gHSUyyWpa8kw/1IjBS6JeEBwDqqJV8Cmg8S
	n4TM4hcW9CFT8tdAzWtxzlui6QkYXCY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-4zojY9fQPIGt3SZ2N5mGWQ-1; Mon,
 29 Jul 2024 05:02:57 -0400
X-MC-Unique: 4zojY9fQPIGt3SZ2N5mGWQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 469471955EB3;
	Mon, 29 Jul 2024 09:02:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.232])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A3F771955D54;
	Mon, 29 Jul 2024 09:02:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 29 Jul 2024 11:02:56 +0200 (CEST)
Date: Mon, 29 Jul 2024 11:02:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Hillf Danton <hdanton@sina.com>,
	paulmck@kernel.org, rcu@vger.kernel.org
Subject: Re: rcu_sync_dtor() warning question
Message-ID: <20240729090226.GB8691@redhat.com>
References: <20240726-ansonsten-piste-c4f04d4909fc@brauner>
 <f4d23fa4-b324-4666-aeb3-ace5c0384e07@paulmck-laptop>
 <CAGudoHHn4bmdR0LetX_bJ1PMtuc6cEYd=hZFutXmqaMG1H+rCg@mail.gmail.com>
 <CAGudoHGznS_Br2gxu=BWsDaCbHmMWRTCmoZDniyFFrDOs9VD5A@mail.gmail.com>
 <20240728134101.GA8691@redhat.com>
 <20240729-imponieren-webstuhl-8ed39923df25@brauner>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729-imponieren-webstuhl-8ed39923df25@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/29, Christian Brauner wrote:
>
> On Sun, Jul 28, 2024 at 03:41:01PM GMT, Oleg Nesterov wrote:
> >
> > So in this case thaw_super_locked() just clears sb->s_writers.frozen and
> > goes to the "out_deactivate" label bypassing sb_freeze_unlock().

...

> So that would mean freeze_super() would've indeed acquired
> percpu_down_write(SB_FREEZE_WRITE+SB_FREEZE_PAGEFAULT+SB_FREEZE_FS) but
> thaw_super() would skip calling
> sb_freeze_unlock(SB_FREEZE_FS+SB_FREEZE_PAGEFAULT+SB_FREEZE_WRITE) and
> destroying the superblock during umount with an imbalance that gets
> noticed in rcu_sync_dtor().
>
> So afaict this would mean that we never called rcu_sync_exit() and thus
> never set GP_EXIT and notice that imbalance during rcu_sync_dtor().

Yes, yes, this is what I meant.

Oleg.

