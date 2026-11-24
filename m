Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795518273;
	b=Z1LOq0RXJtGkzOFs+iNSJQHczaC3LaGjd4njMBGeodDh1q5YkT24xum9sXHBaoGlFjaH
	 tdXrVt2OKULcuCTPj1soHrpkje+4JtDaFX43avZd2wKUGDmDBxRb1P/H6HgeFRc05Ay2d
	 7ncW4Ub8loH68iRY9pIUrK+w6Antcad10XTArpipgVJqbK1uwTqriJ78+2+ObAl5BGczH
	 brFN1C/zzFTABM88iQJQNH+2CQ2fFClOeSuJbX4Y6i7+NaIAhi/CaVeM8838b+SYeu13G
	 sGwvesjX8aYkJabV1Ejx4JJ1w/7k45HN1SwKWkacZWB2a+eh0gfq3f2lu2Rcfhe8/ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795518273;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TTlOMlop88MYRf1Y2eOatTSKCEHNu2LBs6PIdGIA3ts=;
	b=fya/Yc3JVCZlYqo6xWFm/TedMAKuuamB7VvyMZDBkei9wdfO7fuqrknHLIQRDuy2M3BP
	 OYLqNEN56VSuy5mRwUUqHd8WJdnsXKfM3Tb9lTKyyEObwMIiXRGT2eICRvAsOyN9SVCXd
	 tLAOjF9rhh4B3BrhiTGzOK1YN9F7kjdU8nsDFpa0PrfTypBK4ODwTFlcSCgsL022NVcPC
	 IcmcLI1NQegXeC/5mM/5B6VWrYEPmIQ7Ul0+bjfp2KYadmIxHsu4O0N7sDA/8aEiW9mdv
	 7blWhGzesu20CcxKtz/53BRdF/p2Rf3bAj1qk5M9+gaR6RWnSrx+1k1cU8gOvk1jI2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gx0jwKic;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cI8cddPG;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36163606A31E
	for <rcu@vger.kernel.org>; Tue, 24 Nov 2026 11:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36163606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gx0jwKic;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cI8cddPG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795518272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TTlOMlop88MYRf1Y2eOatTSKCEHNu2LBs6PIdGIA3ts=;
	b=Gx0jwKicO6PYN0KjC0d1hd5uBlP1rWdYMXJMVgWllSqFONNKSmOaPMhq4XAJ8o/lVwllkb
	K3iiKZ+DB1KLOpGclifctS0oNLhHl4Rg0FACq9N7FMNFyI1W0QSgwFLdP0pD64d/jYHsB8
	CYitJQprsGT+V5d9qDPt//h4zwf2AnE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-IvCa6RvXNi-vKCiYSUCBYQ-1; Tue, 24 Nov 2026 11:04:30 +0000
X-MC-Unique: IvCa6RvXNi-vKCiYSUCBYQ-1
X-Mimecast-MFC-AGG-ID: IvCa6RvXNi-vKCiYSUCBYQ_1795518269
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e011829easo2617663f8f.3
        for <rcu@vger.kernel.org>; Tue, 24 Nov 2026 03:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795518269; x=1796123069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TTlOMlop88MYRf1Y2eOatTSKCEHNu2LBs6PIdGIA3ts=;
        b=cI8cddPGERKUW1Hg1Xcj05XFux6gB6hsbwlfhHILhMVjH9xrBGWddA61SymLnf3vvk
         C0tuSKGgbr2dUZIk9Wdpm3CGFt0IFCzHLVS7tkSm8XJz094j24tIY0OEM8H16oIibybs
         L6S6/HrZ7T+MuXhJ4d1Enx5nvErwS5A+8ZqQVnHiIz0urEhlteHDoVWhk52WZq4mHYdV
         GTiRFrZmM13sdHQTtcXes5r11rSIVhpxzxG9bY9jXmNft1UFUV2A6zR6lcQaOW1thk1t
         LLtRL0UMZ/LMPh7F9fE4E3Ou7b8MdKOT/vQ38s4yYnTSNJ8QUmZHPkzC56kf1ber0Vqn
         EP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795518269; x=1796123069;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TTlOMlop88MYRf1Y2eOatTSKCEHNu2LBs6PIdGIA3ts=;
        b=BSb1AgzhtKjKa/8D/uzx4D1D8zTNTOAlUBl27mcCT5dfTYTholF5/IYj1/bdx6zFQU
         bd9IhgwWE+4idJpABTou9TwpMkBGJA/vGlhZfPRTGDvd6qot8YXQvDx1PXgWsHMRK+Zz
         NoUEf+QtwaH15raMm2trCqRQdLlvxu2EdolAe1DcyX6+IP2Z4+qGBNqElu8g1Fx+bLS+
         6p7va9F+PdGPVP4AXw6khaNr1PB4nEkpGpZlQLLvmz8pY/Rn+o7M5K+S8AMg4Clqowcc
         lpdVwjEnBwwh3iVeRo2/SaaqNwifsma9YBPacty6GiB7l45ap3K+JqdfpMIU2AucfXJR
         RGXw==
X-Forwarded-Encrypted: i=1; AL+hErGrQMOZGQmT5AM2miOwy0cU5mEGBalY7yeUXFnbLxY2CSkW33BB9j/DQCjVWOUESpuXMio=@vger.kernel.org
X-Gm-Message-State: APuU4Z9E4gS+uBb38CXK0mBfOFcT90ALp4l8U/tdbxbkC29caSeVGYOu
	7Vo7ukqQAlPhMVVIQDlSwEuQ5WyOlgaBE2T6lLN42krjZBeFEYWuGag/xPn7cSF5oSDwuTKdFn+
	ngzuaU2dtLXsXBRK754u77kQ4nEUbJE2wl9h7pGgW0s7iXVxCIZQ4Qg==
X-Gm-Gg: AZFdTZeh+cD3xIULjZQoRJOqBRus8chKhthOiKiwcaoQh/yKehP23dB9wdkFrfiWCt3
	xo6BWr6Sz5GIWS+B+I1Pi+z0n2j3It8+e3Pgvr/wJe9a2a5+KIZrn/T7b/yQz4+d6eZPFXSV87R
	vk/UaeKuQ8zEb9wlhL6J0sNGydgK/7l11B3isCGX0QDf1+CEkcbbHE9jGlhhC7tEjKGJG7FnVY4
	daHXWzyVUx4HdF7vcFcHn0pTz2tzGMrmtmsqMFCS2dJgkiYY+lmbBGoymBE6QGKygH1MnRiID+y
	c7vrgH0AzWLPJhoZ+Bozal100rQX7CT3Upuf/1D8IE6AMBDA10EFlt8T/HTgPzbrTHbk+/WwUjs
	djNtaWOaJgt51etyaTj/uwHyL7H+rGnMtYwf+3oiytewDJVMmC3YDWNtZcOML4yV7Y5KkTPsoKy
	Zoi0s=
X-Received: by 2002:a05:6000:184d:b0:48c:7386:af18 with SMTP id ffacd0b85a97d-4abacfea55cmr29663608f8f.8.1795518268956;
        Tue, 24 Nov 2026 03:04:28 -0800 (PST)
X-Received: by 2002:a05:6000:184d:b0:48c:7386:af18 with SMTP id ffacd0b85a97d-4abacfea55cmr29663561f8f.8.1795518268563;
        Tue, 24 Nov 2026 03:04:28 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b34e9c3ffesm10976795f8f.19.2026.11.24.03.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 03:04:27 -0800 (PST)
Date: Tue, 24 Nov 2026 12:04:24 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	rcu@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	luca abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yurand2000@gmail.com>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v4 2/6] sched: Move DL's admission control to sysfs
Message-ID: <awVvOGe-RwmLCqDv@jlelli-thinkpadt14gen4.remote.csb>
References: <20261123-sched_dl-v4-0-d523e4d960d3@linutronix.de>
 <20261123-sched_dl-v4-2-d523e4d960d3@linutronix.de>
 <awU9KmFsbiyvbcOr@jlelli-thinkpadt14gen4.remote.csb>
 <20261124075332.nZysJRfS@linutronix.de>
 <awVfotZsGc8S_aB0@jlelli-thinkpadt14gen4.remote.csb>
 <20261124103507.4u5Sz_bU@linutronix.de>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124103507.4u5Sz_bU@linutronix.de>

On 24/11/26 11:35, Sebastian Andrzej Siewior wrote:
> On 2026-11-24 10:57:54 [+0100], Juri Lelli wrote:

...

> > > I assumed you use the proc interface because you don't know better. The
> > > warning makes you aware that the throttling knobs and DL knobs moved to
> > > sysfs. The DL bits are mirror to the sysfs interface in case you ignore
> > > the warning and keep using proc.
> > > If you move to using sysfs then everything is fine. From here, going
> > > back to proc looks odd.
> > 
> > Odd indeed, but I wondered if it might happen that a sysadmin configures
> > things properly using the new interface and some time later, say, an old
> > application that hasn't switched yet to the new interface resets/tweaks
> > using the old interface?
> 
> Therefore I wanted to remove the old interface. The legitime users would
> want to change the default DL attributes. I am more afraid of those that
> intend to disable RT throttling and are failing to do so.

Agreed, that's the group to worry about, but they never touch sysfs, so
an error after sysfs was used wouldn't reach them; the warning and the
docs do.

> We could also make the proc interface return -EINVAL on read/ write once
> the sysfs was used. What about it?

Hummm, I'm not convinced. Whether old tools work would then depend on whether
somebody wrote to sysfs since boot, which isn't visible anywhere: LTP's
proc_sched_rt01 would fail again, just only sometimes?

Earlier you actually offered:

> I could look into making the sysfs values appear in proc, too.

This might be simpler. For !RT_GROUP_SCHED, procfs could become a view
of the sysfs_dl_* state, with no second copy. sysctl_sched_rt_* would
only be needed for RT_GROUP_SCHED (which is marked BROKEN anyway, and
what we end up with depends on the HCBS discussion).

