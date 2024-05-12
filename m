Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F0F29B0
	for <rcu@vger.kernel.org>; Sun, 12 May 2024 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715511005; cv=none; b=MVuR6hX1o5ZGK7D7oUpOfNskFoZi6+UxwpC3aaf11BeiA0NvDIxGOb4jjMqKi7zmFDwJNdgd2Q8MobF6803HwH1wL18DEEdMGmzTZD1bRwmjMiX8hq0GnouzSLf9hQIE0V/lX4Xq2KxnJKhWvPWMtdcGSpQsIWWGNdOBZ92XWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715511005; c=relaxed/simple;
	bh=0rdr5+9oRPkVDvU6kbrzwQtN/Z+LPqctRKzqAJ8FT6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mn47Mtq13crKroI5hOs9sRnU0T4741gZuoeuKASY3USDUrWUxTj0QCWgIfPJqJYwwcv+MdaFWmfx3sZRS5Qy6/OXH8mwtLE8wSriU4izExvzNpSIlEamV+LEtA4hVFf3p1Ulu/8H21SweFnCJQH/ecnWYsH+qnt8hgHe4/f02hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jC6jLmw6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jC6jLmw6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715511002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oxrgodSSTuZswJnNY6k+AyI3wOxNGvPqyHgv829oWBs=;
	b=jC6jLmw6aa8/aY3bhGjdcWnfyqBVCiAVSs7jS3gd5dKR3TIyGzYMCHC1t4O1Ko2kA/bkrk
	mGd4tbep6WLx6H/NspmwL0t3aWYdOgUTRNRaAyqP2UcL3URTW11HFypr5w7/YtWaODMrtF
	+GRFTbJc38D1iAiYOBQ+ZA0rPIW4Y1o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-ckBUExiOMliF3DcwR5UIXw-1; Sun, 12 May 2024 06:43:22 -0400
X-MC-Unique: ckBUExiOMliF3DcwR5UIXw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE33F8030A4;
	Sun, 12 May 2024 10:43:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.31])
	by smtp.corp.redhat.com (Postfix) with SMTP id 0DEA7492BC6;
	Sun, 12 May 2024 10:43:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 12 May 2024 12:41:55 +0200 (CEST)
Date: Sun, 12 May 2024 12:41:52 +0200
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
Message-ID: <20240512104151.GA7541@redhat.com>
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com>
 <ZjpAsYJIfzYSKgdA@redhat.com>
 <4c9e89b5-c981-4809-8bc2-247563ce04e9@paulmck-laptop>
 <20240510131849.GB24764@redhat.com>
 <20240510135057.GC24764@redhat.com>
 <474ae55c-fe9e-4668-8f9b-23f819c76d10@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <474ae55c-fe9e-4668-8f9b-23f819c76d10@paulmck-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Sorry for another delay...

On 05/10, Paul E. McKenney wrote:
>
> On Fri, May 10, 2024 at 03:50:57PM +0200, Oleg Nesterov wrote:
> >
> > I can only find the strnstr(buf, "rcu") checks in skip_report(),
> > but they only cover the KCSAN_REPORT_VALUE_CHANGE_ONLY case...
>
> Huh, new one on me!  When I run KCSAN, I set CONFIG_KCSAN_STRICT=y,
> which implies CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n, which should
> prevent skip_report() from even being invoked.
>
> Which suggests that in the rest of the kernel, including "rcu_"
> in your function name gets you stricter KCSAN checking.  ;-)

Yes.

And that is why I was very confused. I misinterpreted the "stricter
data-race rules used in RCU code" as if there must be more "rcu-only"
hacks in the kernel/kcsan/ code which I can't find ;)

Oleg.

