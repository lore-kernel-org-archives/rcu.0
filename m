Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0AC3126B0
	for <rcu@vger.kernel.org>; Fri, 24 Jul 2026 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784899253; cv=none; b=VSgaFdhRtks1vogrQvQg52Mr0oHiNioziHOPqO8qvUzaROHiogBPaV80dmKn7lg5+zpLSGMhsV+VOZiJRpNRRKw97BmyXrXf6QsH4jWasU0a7dQVsW1S2M63rA4GUCS6IQgFi5iwsyWgaT1RPIO/MVWVlu0ANSoOYTuTKwcWrlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784899253; c=relaxed/simple;
	bh=SYjqXWv4bZr6dvi/XqTCd4hnAHLximFwk8qJHz6Za3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5wDDrRUx8X8KrTxPw/JohZyDfQ7xeVWlS0Qp64olQuv6Nu3vvfI47f2PkiCDyHqIUfiGCZM/e+SMMjZ3LKs6dNCEV3PdQef73rPFiFsCrh0USdkVDXEQXsKvZCXWwRuVXtszrHRJK0+fhF5gjHC4wwHa946yvJED6hfjpvnVwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5LVM5uB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5LVM5uB"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954dff6536so3476855e9.0
        for <rcu@vger.kernel.org>; Fri, 24 Jul 2026 06:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784899251; x=1785504051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U75754n2io1Ko0ra9ou19wuxflGdkNj7nt1DvCD1HlI=;
        b=i5LVM5uB4jG/z/P7DC16WFU7DHNO7uzF1Gx99BABpytUbNEtRJdnzg0ooinD6hQi6b
         3GRn3naSB5gPnYjul8jAaMURdiwMTYffL09ybvFc5IaEt6mWokPHyHvU6wPRWwMscr+s
         5JnvsZ9aLt8/GC5BsNpvpwtJVvh7RR9a+LbKP+mgdvjFnvHm6fu/onK6y+t2zsKErZZl
         iZ8k6BiBHd/LSOJzvNHD/d1P/zrGE1eO4QlWq7XBPppwe9RT14QfG8/ODaxfH6WPCO8M
         j/3nriwDfmAxv1AW4Th3+APxZpJmZDNJnssVb9svJgHV44FJ8f+QQx+Ia3B9CSixzqcl
         S+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784899251; x=1785504051;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U75754n2io1Ko0ra9ou19wuxflGdkNj7nt1DvCD1HlI=;
        b=s92sZ2tgHYXIz/dMowOmxyTRcFCA48VXhfbgcY3BGNEaFb/zVx+xNa7UOE/MQhoHzd
         CXAFp2jUQxdgABBsZ9wsnqT1PPxOzfM3SLAupP/2hVqd68FDpEm9eNr33+hna4vWiufx
         8Ewo/1HztkITpD5o7wcpiSwAFFM2bIJHniZ1tztVT35wi/7oQT1gCcsrYTXisoXIpPkW
         t6PyKBXOq32avefmiwvMF53PC9LuYmqLXim+ZfIvxgRDvFoRJM3qKJ9vOLBJ9wYvwDdp
         HyxTzml5GCgI7x3He6mrJYybz8OgoR/ahjC9E+xDrKHoJlRgNWCIbwHRw7DRFNeLPbqE
         ROSg==
X-Forwarded-Encrypted: i=1; AHgh+RpDHq06wv0U4tZEk39Pvz7n1rHZogQJZwWtoZ4QjfWi28nYt1M+kDuVtc5uekqHMsZ9vTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDv5H+JMDop93UFSONcg4nn9awHGUWSqZc0JydcDJ18MpZChM9
	IfwQPvVjGWXTXl4teYbNo+wDcZA/hpMhfCkMERRNf2Dw7rqQ4KFqLfkP
X-Gm-Gg: AR+sD12qbiTXXsIB3VjW0+oxzqIH9tH5D5R8jQYm49Kmc+zG7z8acIBTu/AmitQfxPV
	5uW9X1JA3mk+XOGsBSsA3cQJTkFc5dhuesVG5UInFmfFE69uYOq/MK8VMq15J90gL5VwMuKfWbQ
	TafKlG/+EhuvWhnFyqC3atxJsAVyBHLXFhTyw0X5lpM4cqcHEMaWaycZRbhaQG3Ae9RD0nsLV0a
	wLm64KpmhEief6ZeDfbeQMYugVwEe+FyG9pUYyFDpbL7piT36baCYBob87dL8AYc6NsO9F8YOwX
	CSH/ZvWPGe9rDM4ROKOSnksQQp0ocoOaBnDNL9RlwEVHpGkDIP8RP086Z6+rfD7aSOAodCrGrMP
	8fQiZURhsYQ5b2zY3qjEoONsYZzehMmvx9dha+XpVBOtr7AXC6WcfA84RqnDvkgMmsZ5UiJwg8a
	m8rfFxtNguBQ9Kkdvh22SfbL19qiwfd6+xieO15jZsymL2NhVIzA==
X-Received: by 2002:a05:600c:350c:b0:495:7293:4fe2 with SMTP id 5b1f17b1804b1-49573ce4275mr86077405e9.17.1784899250250;
        Fri, 24 Jul 2026 06:20:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957af6a15bsm78002565e9.4.2026.07.24.06.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 06:20:49 -0700 (PDT)
Date: Fri, 24 Jul 2026 14:20:48 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Zqiang <qiang.zhang@linux.dev>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 joelagnelf@nvidia.com, urezki@gmail.com, boqun@kernel.org,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Reduce stack usage in show_rcu_gp_kthreads()
Message-ID: <20260724142048.53e392a9@pumpkin>
In-Reply-To: <20260723100430.17813-1-qiang.zhang@linux.dev>
References: <20260723100430.17813-1-qiang.zhang@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 18:04:30 +0800
Zqiang <qiang.zhang@linux.dev> wrote:

> When CONFIG_KASAN=y and CONFIG_KASAN_STACK=y builds, the
> show_rcu_gp_kthreads() exceeds the 1024-byte frame-size limit:
> 
...
>  	rcu_for_each_node_breadth_first(rnp) {
>  		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq), READ_ONCE(rnp->gp_seq_needed)) &&
>  		    !data_race(READ_ONCE(rnp->qsmask)) && !data_race(READ_ONCE(rnp->boost_tasks)) &&
>  		    !data_race(READ_ONCE(rnp->exp_tasks)) && !data_race(READ_ONCE(rnp->gp_tasks)))
>  			continue;
> -		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld ->qsmask %#lx %c%c%c%c ->n_boosts %ld\n",
> -			rnp->grplo, rnp->grphi,
> -			(long)data_race(READ_ONCE(rnp->gp_seq)),
> -			(long)data_race(READ_ONCE(rnp->gp_seq_needed)),
> -			data_race(READ_ONCE(rnp->qsmask)),
> -			".b"[!!data_race(READ_ONCE(rnp->boost_kthread_task))],
> -			".B"[!!data_race(READ_ONCE(rnp->boost_tasks))],
> -			".E"[!!data_race(READ_ONCE(rnp->exp_tasks))],
> -			".G"[!!data_race(READ_ONCE(rnp->gp_tasks))],
> -			data_race(READ_ONCE(rnp->n_boosts)));

Isn't that code carefully reading all the values twice?

Also the "ab"[!!val] generates far worse code than the more obvious (val ? 'a' : 'b').
For the former gcc indexes a constant string, the latter is done using arithmetic.

I'm sure there is a good reason for data_race(READ_ONCE(xxx)) ...

	David
