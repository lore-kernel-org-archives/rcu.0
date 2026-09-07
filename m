Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E254F30E5
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795805; cv=none; b=q8g0XWQpemQ8nOh0IxgwwmFi7D3cT1CBkBnyh2ozbHGMLH8ZdawQc5O9hOZvR0tuhjIrKhoHUjLu5lSc8fl4gYYhTBSbtaSBWZck+JRrztBi53aq4f+77QAnTCS8EfYxqEW4yXPOPKHW2bhi97gXVwIrCHi6HT4sIDiQhACGu2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795805; c=relaxed/simple;
	bh=MICC69rDhpY77nwXlWteXYHHthmexIfa62lpP2Cj7Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZSDPUIl7NOJ7vaiEyiED8YBMYzLoszSeLuvjUkIV542ST4rK0TE1LT+V+3/ZfAcPMS/oCRglkh4k8hw6v4NEGXfUkADZty9x/vFhWsqvvxMuO6kkimPO/Klw9OLyJuG9enMjdR6QEEHsvpwyj3T5fwpxAMA39Vbt+f4DiQDXZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Dcby7mMa; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Dcby7mMa"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9399ccafdbfso123807285a.0
        for <rcu@vger.kernel.org>; Mon, 07 Sep 2026 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788795802; x=1789400602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9N6f/b+RDjU+5LdwC1W3FgNOtZzFd5njRslDhw37g/s=;
        b=Dcby7mMa23igHcsyogt4hMcsQ+LF9/ES8wasSJN5liRTHzn6a+6B8eXPqKM0aOy1Uq
         x9PaKWDzBn1NBHviEWZtE9wBpsyTU44o/5IhM4HkZHowaBVBQ7TwQxBmmNUaTpq31Z1R
         3NHxEtcae0R7ht9bjMQLD5quH78Ei9I7pWfkkADIT42Fh3jUNU06bgnkfg3/E4MsGxdO
         LXi0zYbnzstFxw5QmexR0S35KLzBUoQ/5kuCbBwEnHSnlN4Y0CtzlckZOBIq8p12pC6R
         gvaFbq6dtBVtj4sZ/m8gBRTbhGEiaABmWOIhFYsKEQFGBbyytulKzhaZW5RJZqer41Am
         SezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795802; x=1789400602;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9N6f/b+RDjU+5LdwC1W3FgNOtZzFd5njRslDhw37g/s=;
        b=ZiF7D+0dEFg8wP8T7mRVimQOyTZrN5sOsF8AWv7WLEig5ToD4Mpl0ohALL6yD7kUFY
         ElftWnKA+xolW+DSUPclgmf9Y3I34Wdc8rUJPjGpQrvsyJvpugY3SpOE1uLboqZg/M9n
         /CM7gohux6n6khd3DUkShk1quh8VZeAR7DKrxPzala+2nynKkvEXXyOWmMCpv0kISdHb
         Gfz/Iu7fPvLYAcfsvQrBtc5qHKp8z1f9qH113yUVEQwlbAwZMQ/5kbPKw05Xe/B1/Tjz
         xeKf/vTz0NuDjS0hbbn4PT38Q+JGyCDggn9ppSX6zcM/AVLnW+TL8eKgmvTPrSQoaBeC
         2iFw==
X-Forwarded-Encrypted: i=1; AKwUvBw8XMPFzUcCABdCwELOdLi27RXgLTj+kNfvacOVbxo4OcL/1MXuzYSB9QwFa4mCiGltGJ0=@vger.kernel.org
X-Gm-Message-State: AFuF++k3aInnKhCi40Wu6ljuABZTGKxO8xK/0E+47zh7aGZ1EQzTo6Gr
	NtHlJaIxRY8vyhQ93yZwDHGfXVA4LBGr8yoXyR63ghhHcNXBahGqYzGMMMSnzuVOURw=
X-Gm-Gg: AYBFou1pqV7IdWgVl2dGGTtG0aiUZPfsS41Huc5guFJjePQW3DqCQZwli+eK1gS+dy7
	Ik97ujaFRQcHasdm7woCo9OiZIVEPw6lfZUCsYN3doAjcg+S6JzCFKZXep10hKz9NALs1mfSmFB
	fbvnELOGNUSH6xosWyau7f2dadcePTNmqvrDeI8ikeLx2IZAbamt7mlPSDF2ZoiK3Jm8DzYL/bq
	71JmV7/kH6BEQq0tv3L02zj/6CPj+9jLOGsjEWlKgiCvzQg6JS4f72hsv4s1qBfLN2uaaSUdXWN
	C9uJiHQoUelhvdj7rGHoqV4RVTGJUiHV1bquzQ4OCQFx3Il7frv22TjIu44jBFtEYVvZ/eKZ1nw
	dPJWTus4pZaeryJnPodjFgzKQkpWuyY7pNadKOZX1GKne3oW1BC5mH58oyD9Ob+m6StYhne5Cl0
	RE8uomAXZStTnaHs7TCrA43hbapXmXLbclpZ4PmOhRJRuMUnh8mmc/0T1wHNtVNUWjmMs+g6bHi
	kLLvEfUfo9MCCOoq9YuFu8wmtPnAxrbTHUOj/4rfcEO
X-Received: by 2002:a05:620a:1a10:b0:939:93f:3b41 with SMTP id af79cd13be357-93980341197mr2411106785a.16.1788795802336;
        Mon, 07 Sep 2026 08:43:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406bf8c3sm94620766d6.48.2026.09.07.08.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:43:21 -0700 (PDT)
Date: Mon, 7 Sep 2026 11:43:19 -0400
From: Gregory Price <gourry@gourry.net>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Ye Liu <liuye@kylinos.cn>, Michal Hocko <mhocko@suse.com>, 
	SJ Park <sj@kernel.org>, peterz@infradead.org, paulmck@kernel.org, mingo@redhat.com, 
	rostedt@goodmis.org, jpoimboe@kernel.org, mic@digikod.net, oleg@redhat.com, 
	tglx@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com, rafael@kernel.org, 
	gnoack3000@gmail.com, ljs@kernel.org, rientjes@google.com, shakeel.butt@linux.dev, 
	xu.xin16@zte.com.cn, chengming.zhou@linux.dev, will@kernel.org, boqun@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	josh@joshtriplett.org, urezki@gmail.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pavel@kernel.org, 
	lance.yang@linux.dev, mhiramat@kernel.org, pmladek@suse.com, longman@redhat.com, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, mark.rutland@arm.com, Dave.Martin@arm.com, james.morse@arm.com, 
	babu.moger@amd.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 3/8] mm/ksm: convert process iterator to
 for_each_process_rculock
Message-ID: <ap7biSs63MDeB34i@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-4-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907081334.1152889-4-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:29PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
> with for_each_process() loop in mm/ksm.c with for_each_process_rculock(),
> which scopes the RCU read lock to the loop body via scoped_guard(rcu).
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: SJ Park <sj@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

