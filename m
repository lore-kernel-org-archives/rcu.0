Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942525334B
	for <rcu@vger.kernel.org>; Thu, 18 Sep 2025 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758196218; cv=none; b=DAyJKrRu0ugQ7sGa4FPnXd6GdpGEE8D5um/EJWPmX5SBGYb5RYQX65FBWVLDidnGuC2G6ZpVHN/8dlcp83r2KPIgM+miWW3KhJkMXeNRi7JSQ1ka5ZOhvIKVhNfAcV0xu36FEWYW1HwHwLhrkDPDGk6wAg5MzykQE9sZcmVZHqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758196218; c=relaxed/simple;
	bh=AREG0Ed6XIrfjpFk2BxwkOHkPxkyb+CLxTDrPhGjcMI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcqLhnNG8VUe4GCBk7c+SoybZm8GqLSVCu6UevVflwlSKM2Y60Cizk0VHarmGRfaPb6zBFN6A6UeTMIn8ItRwD17cRP/iSfW+q/r5OcV+p78uZXKlNW45kGZeLAoYHcsXVTgQ8N655w6Xg1jYKItgJWuJfdS6r4Cs34EhoLls3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFRXeW8V; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFRXeW8V"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-571a58b385aso1136556e87.2
        for <rcu@vger.kernel.org>; Thu, 18 Sep 2025 04:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758196215; x=1758801015; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cinYAB168v/wb2VrppQflF57ZyFZxmkxcgnsCP7opUw=;
        b=UFRXeW8VGCW9dO2yUbiqxnPkchB3DxnV8M9pt5GRF/bUTSSeZU7q17IEQdEo4O1qf1
         XLKE3C4pc1NU3uJ+AC2LlWB9ssr+Iqxgg3NuCPW05A+NDwJp00uHqvqGmSRHt3UJYVYI
         hp1Y2cPRXyfVEUjSIszeoVxgQC+BgEsr7HesXL01Vx60iNNUZOJbWL3Ds3wVOv8TuvOU
         oAb0+rtZefWHJeKdTMvuRA/LQdw3HvuUGC/6ZL5c04X9V+l0ygZ7lOpASuw8nEE7cd0u
         G+JRMpn3cFPBzAeBvam0dUgY3UnBZdUalM62sw2pSf3dhlU7oq67zFvctLbxRmBfglVJ
         ciVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758196215; x=1758801015;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cinYAB168v/wb2VrppQflF57ZyFZxmkxcgnsCP7opUw=;
        b=h1JwjKMV0F7UaGNZGoTqzsQHVKGk6jnga+p6LF5VRPdiss9/Rb8xNgFHCmET3CMoGk
         GeofF4YHxbVDdQhsu9GvB27FDIW9HxB98JtpxNsODFzGXYcivCb9MXiI3PTpav9MUdko
         waK9NYpgiP4igb3vNRRXbsj11olBhhLdj7nwMPGd2fmfvC+PuGaLicmNCxWmplSxGDcK
         Kfpj3nbdj4AqXku+0DfMsqd4BhVVPAAtwnPwdbHwWSOLE3l29TUwEAAxsdwPWzIuJawb
         ZhiQswNuMcELfoXHhJ4dpwyAYqK96JmU87daRsJ8ykg5lMGQmNQoZBsiZcInMzfB6ZM0
         JjAg==
X-Forwarded-Encrypted: i=1; AJvYcCWddC1b0N5bwiJvWlr7b3+ik71QULy8IR11GWQ6fA3owA6/w4WUz1d2GWpPjpcbwB36Pok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza6G585qiC9n4ILhkk2StHl/aWaaqRfK3GstXI0qZOpj/CTuWz
	OBxwbcGRDoifsB7H9nsnR0Gre2Z8mnQtPurk1+jBiZ1K/24uvWX07RIN
X-Gm-Gg: ASbGnct9B1zjFvkRCfEOvUWN1AcOMe5TkJo6Ofal4KwrYQgRiAvAPKtDrc2nJIZdPTU
	kLfI35TKGqTh70N+6cMNEyYx9jmIq1EL4fIHqTiYiJ/jCkSROCsHYLBpludW7nvZnZ1++gugSSW
	gQJ62WXlS2JF5l7eQ+AXnouNdgzarrfo74Jtbr8LH2NHquHPfjoqZ/JbHxB7SLS627kND0/m+Iw
	OMyAbGl2/shkZ295gcfd9jE2bSUz1PtwmXWe2EZowAeC+6u4KgBLPuILXUXszVHMR9I0rRTuSDb
	dNJ6GcppHhFr2sZQlL+P/WFSScqGywn5D3pzrHqqVUj7Mlvpgfjiy4wiQH82BJHJH8NPqB92seI
	iGi+TaTPw
X-Google-Smtp-Source: AGHT+IGPXawyjl1pf4A0JhR7iwy1/wI6/9VL3klvy4kLXlBQi62TAUdK1LlD/gQhEjPPojUrq+oGdA==
X-Received: by 2002:a05:6512:3e08:b0:55f:572e:2417 with SMTP id 2adb3069b0e04-57799ea9e63mr1847687e87.56.1758196214358;
        Thu, 18 Sep 2025 04:50:14 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a68e26d2sm618824e87.54.2025.09.18.04.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 04:50:13 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 18 Sep 2025 13:50:12 +0200
To: Suren Baghdasaryan <surenb@google.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
	paulmck@kernel.org, Jan Engelhardt <ej@inai.de>,
	Sudarsan Mahendran <sudarsanm@google.com>, Liam.Howlett@oracle.com,
	cl@gentwo.org, harry.yoo@oracle.com, howlett@gmail.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	maple-tree@lists.infradead.org, rcu@vger.kernel.org,
	rientjes@google.com, roman.gushchin@linux.dev
Subject: Re: Benchmarking [PATCH v5 00/14] SLUB percpu sheaves
Message-ID: <aMvx9GKgIWtrkZ_R@milan>
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
 <20250913000935.1021068-1-sudarsanm@google.com>
 <qs3967pq-4nq7-67pq-2025-r7259o0s52p4@vanv.qr>
 <f5792407-d2b9-42b3-bc85-ed14eac945ec@paulmck-laptop>
 <d1ef1cbb-c18d-4da6-b56b-342e86dca525@suse.cz>
 <CAJuCfpEQ=RUgcAvRzE5jRrhhFpkm8E2PpBK9e9GhK26ZaJQt=Q@mail.gmail.com>
 <aMpE-oSjtlDU4TSl@pc636>
 <CAJuCfpHQ_JedSRHKKoYXyVzaFOm=dDWzgFZwqerfEC1fn35j0w@mail.gmail.com>
 <CAJuCfpE48n=QM0nY8yE3drqZU0wgC76=70EyftL1WZewEcykyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpE48n=QM0nY8yE3drqZU0wgC76=70EyftL1WZewEcykyA@mail.gmail.com>

On Wed, Sep 17, 2025 at 04:59:41PM -0700, Suren Baghdasaryan wrote:
> On Wed, Sep 17, 2025 at 9:14 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Tue, Sep 16, 2025 at 10:19 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > >
> > > On Tue, Sep 16, 2025 at 10:09:18AM -0700, Suren Baghdasaryan wrote:
> > > > On Mon, Sep 15, 2025 at 8:22 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> > > > >
> > > > > On 9/15/25 14:13, Paul E. McKenney wrote:
> > > > > > On Mon, Sep 15, 2025 at 09:51:25AM +0200, Jan Engelhardt wrote:
> > > > > >>
> > > > > >> On Saturday 2025-09-13 02:09, Sudarsan Mahendran wrote:
> > > > > >> >
> > > > > >> >Summary of the results:
> > > > >
> > > > > In any case, thanks a lot for the results!
> > > > >
> > > > > >> >- Significant change (meaning >10% difference
> > > > > >> >  between base and experiment) on will-it-scale
> > > > > >> >  tests in AMD.
> > > > > >> >
> > > > > >> >Summary of AMD will-it-scale test changes:
> > > > > >> >
> > > > > >> >Number of runs : 15
> > > > > >> >Direction      : + is good
> > > > > >>
> > > > > >> If STDDEV grows more than mean, there is more jitter,
> > > > > >> which is not "good".
> > > > > >
> > > > > > This is true.  On the other hand, the mean grew way more in absolute
> > > > > > terms than did STDDEV.  So might this be a reasonable tradeoff?
> > > > >
> > > > > Also I'd point out that MIN of TEST is better than MAX of BASE, which means
> > > > > there's always an improvement for this config. So jitter here means it's
> > > > > changing between better and more better :) and not between worse and (more)
> > > > > better.
> > > > >
> > > > > The annoying part of course is that for other configs it's consistently the
> > > > > opposite.
> > > >
> > > > Hi Vlastimil,
> > > > I ran my mmap stress test that runs 20000 cycles of mmapping 50 VMAs,
> > > > faulting them in then unmapping and timing only mmap and munmap calls.
> > > > This is not a realistic scenario but works well for A/B comparison.
> > > >
> > > > The numbers are below with sheaves showing a clear improvement:
> > > >
> > > > Baseline
> > > >             avg             stdev
> > > > mmap        2.621073        0.2525161631
> > > > munmap      2.292965        0.008831973052
> > > > total       4.914038        0.2572620923
> > > >
> > > > Sheaves
> > > >             avg            stdev           avg_diff        stdev_diff
> > > > mmap        1.561220667    0.07748897037   -40.44%        -69.31%
> > > > munmap      2.042071       0.03603083448   -10.94%        307.96%
> > > > total       3.603291667    0.113209047     -26.67%        -55.99%
> > > >
> > > Could you run your test with dropping below patch?
> >
> > Sure, will try later today and report.
> 
> Sheaves with [04/23] patch reverted:
> 
>             avg             avg_diff
> mmap     2.143948        -18.20%
> munmap     2.343707        2.21%
> total     4.487655        -8.68%
> 
With offloading over sheaves the mmap/munmap is faster, i assume it is
because of same objects are reused from the sheaves after reclaim. Whereas we,
kvfree_rcu() just free them.
 
Thank you for your results.

--
Uladzislau Rezki
