Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EE02500DF
	for <rcu@vger.kernel.org>; Tue, 14 Jan 2025 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736844041; cv=none; b=jiMxFRCf+dWBJMdasiXNL6CkvmxclGhdd5yVOVAM9r/ZIAg1Qx6liXA5nGDY+hNLKI3qdnHTMKbqPAoKpVdHCD0+86tDHMqoKRDwMNUQH3j9wM8KmtejJ5kZw9mD11o4VjWN80nDb/CwnTLLbQ3Q0ud1G+DUlos0TT1v/rWz20o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736844041; c=relaxed/simple;
	bh=HDLh4ABY5og73UWWJiQ9ZMxp/+5sJtvgGr2cwpqz74w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6ePQZJYQApkdzEcScxH8uT1faql+mTdArQJkQYjZjXIO1UFE16JxteovOFiUcQcx7Ix++Gx83fmFXWZB+TAW6jfTe3AZaGR0zFpdeaFUqt7w5TL8SNqXzqlutCNOL61E2coCYhVR6SARnWsBg/wy31bFxQPDasSrNzYSHuH96s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PSt8AdUb; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PSt8AdUb"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so3053517f8f.0
        for <rcu@vger.kernel.org>; Tue, 14 Jan 2025 00:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736844036; x=1737448836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=arro8hqRUCXkL90V/UNNtQl0Bv9DZZdmFTRHHjOo6Ys=;
        b=PSt8AdUblbgI6lmNML0cZAZaW5nHD5u1LWoaUYMGtZkanN/li6znBJ7afoXJtn64o+
         vA4r1Fdw9s6fWGKL2069Hnb3VjwIfmguzypCcCjSkvGo91IqLYv8RwCLJgK9wZE88pXW
         nPbSkIb30P4mzvNEG8LsufwTeJ1OhMBj3pxfEDPUt2fYrk/dn5qTTKjamSMeLuPu6zmo
         xUBSCrfrMQ5J1vet8kpMtvnQy9tceYH7n8SyOssjpVK1YxhUjgQFRDlbx9jMcZT039B7
         fs38j2YDP2wjU7mMI8h4r8biaVJhElaOKPKLs6sSjdYfSAc8ZQFR5Q0vjKtoayiV7mfD
         XyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736844036; x=1737448836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arro8hqRUCXkL90V/UNNtQl0Bv9DZZdmFTRHHjOo6Ys=;
        b=ST/bfEbDEwmvAMaP8ln+AUDr49egN3GkVMbVMnrRllWl8xH/e8HWaE0x2uDNHZzTqo
         A+ThPuB+XEIo8Cd5nDrMj1S8FDoZJIAq0DxfUqIFLvbkwILrKG13FlcDFKGcs061RJBx
         hul2kMqFIZQqcMBq05EWyKPRPbL10US6JdSbHAKNoDM3FlBTQT4l7gZQKluqDfKPhj2F
         d3vSGa6m/O8YltKzasZBDHVnzpMQaGvmnVQAlIqJTouZeMdlajR7ZOVTGlhRASEXzHF9
         9ip3h7CA7+2Jjggvopdn/AXO7exLlMXDHb2Md3sVUdtgVcKe6w33lMgDVbOdM23Cd4Ui
         ilww==
X-Forwarded-Encrypted: i=1; AJvYcCXps7356qwlL4nbX4cwJyABZ7R/uI0ynCB1LNY1QONkSqZH5T9hF3QGJw8EaMPt4EJzlPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzfd+6njWErfn3cj4FtQiao6EWGl7vdHkbLIREyiDDWl8w89zH
	7VOX35VO2qIC2hf0qUl5yOBtifWVK+CkQL89Q+l8K9vaIBmhpY3nxWojfi8NYcE=
X-Gm-Gg: ASbGnctdhi33PIeZsiF3JKSFwce9oBPPz7s+F55BK0QrzjQvTHvM3tiFk6wQCQLHej1
	WQplet7NqONbDtN7YPyIMdr+qcCYa/iXH1SwubMqCd3it6CeVTSYKY0VUbnURo3NZ1dtaiVyuw9
	2TufEHlX7AmofqZHVdjyGbAkFQgk1N+IaFQgO4WWY4wL6cfNwgGtah1TAohtjcn4+QQMDY8gNmg
	NdAvbsFlnO9SEd/yNFVWOvqYQe2LrBvJjdKtgKP8KOkp16w0qCBiqyXsU7F55P9bYeJ1g==
X-Google-Smtp-Source: AGHT+IE1cZ5Uou0ZikaojmMVGumlPj++UeBWrnDMQpxuLsFJ2giWup6lhK4Jzd72u8Y7fFKBkRcd3g==
X-Received: by 2002:a05:6000:186e:b0:38a:8d32:272d with SMTP id ffacd0b85a97d-38a8d3229edmr17003016f8f.28.1736844036090;
        Tue, 14 Jan 2025 00:40:36 -0800 (PST)
Received: from localhost (109-81-90-202.rct.o2.cz. [109.81.90.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b80b2sm14026164f8f.80.2025.01.14.00.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 00:40:35 -0800 (PST)
Date: Tue, 14 Jan 2025 09:40:34 +0100
From: Michal Hocko <mhocko@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chen Ridong <chenridong@huaweicloud.com>,
	Vlastimil Babka <vbabka@suse.cz>, hannes@cmpxchg.org,
	yosryahmed@google.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, davidf@vimeo.com,
	handai.szj@taobao.com, rientjes@google.com,
	kamezawa.hiroyu@jp.fujitsu.com, RCU <rcu@vger.kernel.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH v3] memcg: fix soft lockup in the OOM process
Message-ID: <Z4YjArAULdlOjhUf@tiehlicka>
References: <20241224025238.3768787-1-chenridong@huaweicloud.com>
 <1ea309c1-d0f8-4209-b0b0-e69ad4e986ae@suse.cz>
 <58caaa4f-cf78-4d0f-af31-8a9277b6ebf5@huaweicloud.com>
 <20250113194546.3de1af46fa7a668111909b63@linux-foundation.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113194546.3de1af46fa7a668111909b63@linux-foundation.org>

On Mon 13-01-25 19:45:46, Andrew Morton wrote:
> On Mon, 13 Jan 2025 14:51:55 +0800 Chen Ridong <chenridong@huaweicloud.com> wrote:
> 
> > 
> > 
> > On 2025/1/6 16:45, Vlastimil Babka wrote:
> > > On 12/24/24 03:52, Chen Ridong wrote:
> > >> From: Chen Ridong <chenridong@huawei.com>
> > > 
> > > +CC RCU
> > > 
> > >> A soft lockup issue was found in the product with about 56,000 tasks were
> > >> in the OOM cgroup, it was traversing them when the soft lockup was
> > >> triggered.
> > >>
> >
> > ...
> >
> > >> @@ -430,10 +431,15 @@ static void dump_tasks(struct oom_control *oc)
> > >>  		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
> > >>  	else {
> > >>  		struct task_struct *p;
> > >> +		int i = 0;
> > >>  
> > >>  		rcu_read_lock();
> > >> -		for_each_process(p)
> > >> +		for_each_process(p) {
> > >> +			/* Avoid potential softlockup warning */
> > >> +			if ((++i & 1023) == 0)
> > >> +				touch_softlockup_watchdog();
> > > 
> > > This might suppress the soft lockup, but won't a rcu stall still be detected?
> > 
> > Yes, rcu stall was still detected.
> > For global OOM, system is likely to struggle, do we have to do some
> > works to suppress RCU detete?
> 
> rcu_cpu_stall_reset()?

Do we really care about those? The code to iterate over all processes
under RCU is there (basically) since ever and yet we do not seem to have
many reports of stalls? Chen's situation is specific to memcg OOM and
touching the global case was mostly for consistency reasons.
-- 
Michal Hocko
SUSE Labs
