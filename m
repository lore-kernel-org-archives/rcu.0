Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795506979;
	b=kviR27TsqGL8dgGweTfRX9G0kf3PobUvhe3yieUMRIFPMdBh98qhCeJMoY3lGr1YLzUu
	 M8g9tmc7Pvo6VIZ22vGNvQCxxM5lgYlqTYMqkNXomgwCK5NUmqOZqyPO/yG0hUGYA8uo6
	 KdvO8d6+hbWP4yVTkuQLOuS/4491zc5KBUuIQ2aJwx89Qhhl57JK83TRR4pkIXR2e9Lcz
	 R99ng61OAb1Qr4QuStn06JvRGQjnmWKTjQU+PMPjg3Zv4le18bJK3jxU4kUapz5frgOIB
	 nEmtvY1roWJ4PkmdGzGOC/o1ELmp0zBFIQXtKKecU+ITkwHz8L9L8dcpD/rkedZm++g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795506979;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NoYyv4wajWc0F6aGxtmlY+0UYbCgY2jiNDwc0W/rZK8=;
	b=FmBk4Vp8/dQmhSq+Itn0vFVeeFb4dJK2v+OtyHG49JGprxutmEbUE3xevO9riay9jUme
	 4VHxnpKtbOVGzwQTaAfjSlviWigRIlrAwCuoauLKncWoOXxeGGCCieVNVJyDAM7DfrRr/
	 qKcwODRT+hfHS3IA9dlbk3JaMBDo6CQKhdBGDNDzYsgwYvDhLYpgrIOi9L90qgZvNxH2A
	 o08kmfmdZUqmheVnZ7p/7wiWrc3wAG73fsBadop9TLRfajgmo3OgnSPP3d85rCuSi6TWL
	 SVrbK+mjMdecB1wRBx264/W1qouniGEjv/SKBcw0sBfdiF9XdoL74PeNQ7aZSVHo8XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y0Jdg16j;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=U0UeFabM;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F4C606A322
	for <rcu@vger.kernel.org>; Tue, 24 Nov 2026 07:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0F4C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y0Jdg16j;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=U0UeFabM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795506978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NoYyv4wajWc0F6aGxtmlY+0UYbCgY2jiNDwc0W/rZK8=;
	b=Y0Jdg16jJkxsJ01Ybn6vnG0AvnkFHRNLGgNFt8lvJycpyX7rr1z1bVD7oypPeWkk7o64Mx
	pPtumeyxHcOwnzP3qwc8liuIYPD8+4cFBOmUuktGD92hpTkD1R8NW4bUUV8IOT9Vjr07vt
	ce6nYeYRDV0g5ubk6U2j58vk6hv6xc0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-KQrBYeOoPOWbanF7aaNpKw-1; Tue, 24 Nov 2026 07:56:15 +0000
X-MC-Unique: KQrBYeOoPOWbanF7aaNpKw-1
X-Mimecast-MFC-AGG-ID: KQrBYeOoPOWbanF7aaNpKw_1795506975
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4a3705ea6ccso2237308f8f.2
        for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 23:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795506975; x=1796111775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NoYyv4wajWc0F6aGxtmlY+0UYbCgY2jiNDwc0W/rZK8=;
        b=U0UeFabMFf/ISUizAhh59HUlDp0z4hAk+BCdZZDw0RExDHxcCQfox5bhpve1ghnCTi
         cPXjrlVsFre70PX9D+3E7Xcn1cRNP0OoMtGZB92jzfCBv7uVJE34uOkgF3eXKfiDCd/W
         E7jVYMWFaR2O/PZMSdsmJwwIAa9NPe4MnnTccbDIDm5mq/pc3dkGLiSA1+sNa9G2nNf9
         RFy6vrgASvUAYCp6f4RXyrEAJ29S5QgXjHCWs30hZvbuKpe27qKD/ka249BE1dkZ1l/m
         RPuFiEzHME0ypT+0bIlb+R7NqYYYITL7TVrqcxMujUWptvNFN5HZZwl0V7ZPB0ONpDe+
         KgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795506975; x=1796111775;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NoYyv4wajWc0F6aGxtmlY+0UYbCgY2jiNDwc0W/rZK8=;
        b=WszStkw5lUIaLsy5p0J440jMY+AGnjQqEAsnwUDQH7V2ocTu8ZgWYaUhoD8F8DDOo9
         aw2s99fAM/xH4cwc72fV7wrT7+sNxsYe+9l+UFJ/B/X/9RvCO8Mc7z+UZ2/wzC3Nj+nJ
         JVj3QclRM/DNQ9GdUaVyytutrRxaenLdKYp7Pt9I6sU4l45KiT24p89mDUkoILQfcmRc
         VYcYuLlKwRIhd1iCaBTmPJaY6GbS8QMYu+ncKp8GPcjpxBuSCC9ZEkejsAuq9PE3WcZW
         4CZb2WpiGcQkrRwKp4/RGuYGctBFkfyldgkNpMWXCI+2lRsIRq/18MqyhgzehjM2uDDg
         Bmcw==
X-Forwarded-Encrypted: i=1; AL+hErGlOK1HoDIRtV3CTtFpWY/fKBxBpnoZ9igbrk4zpo6QPcW0KEdmiFaMcfhvrVYkeWPi4Fw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Ei1mfPNmmx7QKm5iuK/VONJ+7vIBBoRdZ2IbsDHJqhT46qLjR
	1ZpYgYnC1fr7pv+oKAQQfWFxf2Hh+kDWTl/o/EiPmSQn2hduekXV/7FxeqwxPF3qQqbb2KDTpqD
	6aXxB5kte1vb8qWvAEloa3lBhQHvciVJo/gq4fu6zg8kEJo4hNj6KJA==
X-Gm-Gg: AZFdTZcxllclC991EmSMYVMv5/esM9B7TFk+QwVxBE4oX4CyPNIRZvucbd6+zM/KL+p
	j2elKAIYJTRPM3SOHdHtI7s4VkXZL3SqSyhS2zBsYNMgOhdN1xb44lm18T0ZlkxeAeKcclPYRtU
	OwPkRK0IkC0/JwzXCEplXDx3u+jVIdFsYcE06czoiwNGRq//3ToAjKwyIT0sDNmZEK2faWgzNzL
	XQPnQIjnvCXsG4AbGV3J4DEux6UllgiaB0EuN3zgrWg1lndmbbDBI9bOpRn3yRpo43rqyXCdcbd
	noIYG0DYAj3H/Zh6ZvVSXFbYthlUcwpVLMBHyIGG+/IWPTq6Vgg/fxeb4TEzl0wx1GQng76sIOn
	VFNOkLyiELo+fcOoYRB3MhmjId3okZgo5NTTC/PYRVJDCXjORAXrr8yL8N0C9+3EdlMy8sbiN5u
	CDx5o=
X-Received: by 2002:a05:600c:1549:b0:4bb:6f45:2a77 with SMTP id 5b1f17b1804b1-4bb8880abf7mr268984125e9.11.1795506974706;
        Mon, 23 Nov 2026 23:56:14 -0800 (PST)
X-Received: by 2002:a05:600c:1549:b0:4bb:6f45:2a77 with SMTP id 5b1f17b1804b1-4bb8880abf7mr268983605e9.11.1795506974353;
        Mon, 23 Nov 2026 23:56:14 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c340df4sm30623656f8f.55.2026.11.23.23.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:56:13 -0800 (PST)
Date: Tue, 24 Nov 2026 08:56:11 +0100
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
Subject: Re: [PATCH v4 3/6] sched: Add sysfs files for the per-CPU
 fair_server knobs
Message-ID: <awVDG-ABOvj7zGRg@jlelli-thinkpadt14gen4.remote.csb>
References: <20261123-sched_dl-v4-0-d523e4d960d3@linutronix.de>
 <20261123-sched_dl-v4-3-d523e4d960d3@linutronix.de>
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
In-Reply-To: <20261123-sched_dl-v4-3-d523e4d960d3@linutronix.de>

Hello,

On 23/11/26 14:41, Sebastian Andrzej Siewior wrote:
> The fair_server exposes the runtime and period knobs per-CPU in the
> debugfs folder. The debugfs interface is not a stable ABI.
> Make the /sys/kernel/debug/sched/fair_server/cpu*/{period|runtime} knobs
> available as /sys/kernel/sched/cpuX/{fair_server_period|fair_server_runtime}.
> 
> It adds a struct kobject to the rq and exposes only those two. The
> per-runqueue folder is named `cpu' rather than `rq' since it might be
> more intuitive to the user than `rq' or `runqueue'.
> 
> The set logic is pulled from the debugfs folder but it is still shared.
> That debugfs logic could be removed (after providing the same for
> ext-server) or symlinked for a while.

...

> +static ssize_t rq_fair_server_runtime_show(struct kobject *kobj, struct kobj_attribute *attr,
> +					   char *buf)
> +{
> +	struct rq *rq = kobj_to_rq(kobj);
> +	struct sched_dl_entity *dl_se;
> +
> +	dl_se = &rq->fair_server;
> +
> +	return sysfs_emit(buf, "%llu\n", dl_se->dl_runtime);
> +}

Since these files are new and meant to replace debugfs, how about using
ns everywhere (you partly commented about it in the cover letter), as
sched_attr and the dl_server parameters already do, with the unit in the
name? I.e. fair_server_{runtime,period}_ns here and
dl_{runtime,period}_ns in 2/6, with only the procfs compatibility path
converting from us. Right now /sys/kernel/sched/ has dl_*_us in us next
to cpuX/fair_server_* in ns without a suffix.

Related, do we need to add Documentation/ABI/testing/sysfs-kernel-sched
entries for these and for the 2/6 files (units, defaults, limits,
what 0 / -1 mean, -EBUSY on admission failure)?

Thanks,
Juri

