Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E86959B7E
	for <rcu@vger.kernel.org>; Wed,  7 Feb 2024 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318785; cv=none; b=t3IQONkwpkvq2K9E2Cv/nPL37dC/cAFd30doxIyRnlLjTpgpZy24V18BfRpkLI1W5xfqqruQv4HQifLoam8HDn2U4dPBpVcyWLEpHWZzxkO9ZY8YARmtogvux1cLOreVvypT3MuuKG/RJjd3PHn0HnvSG3Sf1CM739dZVvJNc2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318785; c=relaxed/simple;
	bh=dqOwU8uND6czv3BzL1gYGmol8p0E71OBB7sTU6edAxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEpzGJgW18TszJxr2kAgCl3y5k8er7q1/L2g5d5LZs/ZYL1VA5rNORl1ZsQXkEcQRn9Ld81MlfVLfLxJgj98+EBySaDVckdCAN/iUWPCaTYdT/kjH4cyzmn7yM7JgrDnfHMH1XX2imPDgW/3iPhlsZggomtduOqveMTyRFi5qAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DUjmkjv8; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DUjmkjv8"
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8BFBB40606
	for <rcu@vger.kernel.org>; Wed,  7 Feb 2024 15:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1707318775;
	bh=nDWokVGFpV3vHGNxZvMcm5ItVC5TKdedPzvIpgjtZp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=DUjmkjv8GY4w7zs02YyQjBhhz2pSsz9AqSX5GBCA9plQ23MlZ5iw4Z7/mnuk0g/zF
	 397K7kd+dkKWeBOpebQOwFMPumcnWPWZcxo/1ZDnyUhJ8El7ExvLEXHhibZf3gUEsI
	 7SFfTYY8kkWdwBageLW7qWuO6K5qqAHTyVvqzZP4cIyohOlw4Od3HSWjJ3mlLcFe7g
	 qnFJwBo10oIycMk6Y0zL7nHBSlPP9m/OPBcvUEg56p0wiOMMsQRyWTd3i0zCt7j6cg
	 pAgww8ARbjRs75HWGsZ52GzQgTDh1XNvBjza7ij1ZeDWu/l95mFF5WwHCfMYO2ESUw
	 /0CKzkde4VgdQ==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-558aafe9bf2so638196a12.1
        for <rcu@vger.kernel.org>; Wed, 07 Feb 2024 07:12:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707318775; x=1707923575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDWokVGFpV3vHGNxZvMcm5ItVC5TKdedPzvIpgjtZp4=;
        b=mpEvHsadO2iSRN/NMq4icL1t6Il1MOpE/WQulBEg92UPKkzBQ0el11YSlyh1XKY8MK
         A2wW5Bk8zZaP2oTJJysL9DzRMOKsoCQwkOph8O1qL2hstpy7iDCs8N1WyuZc2Ul3t73r
         58hUS1eavqQ96rk0+YaTxX64JL4V3ck6BGghiCiYL0UxLxWKe4RaSfxbFqKNvcUrLKb4
         VoYSbgzEJRCF7VRZyepjtbr3a1TtB9pZzrXTzRdZ6LqLZ7IeMZ8qn1riApgZYmbQG6cI
         NyjS1ZoA98KRPLGuDtrdTyFTuZeNcpuyPpa+ocqol5Ij06sdJi+1KrqdlpGxprUaPzLb
         vrtA==
X-Gm-Message-State: AOJu0YyThDGufORhUL0SyK2M8mH+vyplJ0ZHG6N6lsWGAwmL3WWG9eja
	2FYwtclQwZQ7Vs2jo6HJZEjbWp6+mFUqK5u7fcnCjatAIk/ItaI/bXcHSHvIbPnmTPuZVwXSEQC
	6vYDweR4MsaBodk82uRg3UMPjGzhkU3WKS1Vh/irLyBJah42djWUX+gydcA+dmgl8cw==
X-Received: by 2002:a17:906:44c:b0:a38:8cc8:1197 with SMTP id e12-20020a170906044c00b00a388cc81197mr1115756eja.2.1707318775217;
        Wed, 07 Feb 2024 07:12:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjUblLrm+tuJ5Sd4h+p8/GRkNYwbPAM72sH1xKUj82IyGS9HPdZx7buA5shOLQmPyLsr7l7A==
X-Received: by 2002:a17:906:44c:b0:a38:8cc8:1197 with SMTP id e12-20020a170906044c00b00a388cc81197mr1115635eja.2.1707318772801;
        Wed, 07 Feb 2024 07:12:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQobeOPUpPTnddo/YGFKrQQNp5ew7uQWbDDlC8il+HXnslhJBQHEdiAu6NGZVBug6/VMG+FaCf2pO/ydQLL5PfI7lkgoeFQkuAwEwtkvSO7XukLtv30CK7xJQfpyvp77gOeQO40ykfyEodnLib071MWBTtDWZYGkt/h4zcGW+qfj1Z
Received: from localhost (host-79-53-78-93.retail.telecomitalia.it. [79.53.78.93])
        by smtp.gmail.com with ESMTPSA id ga25-20020a170906b85900b00a389490cb05sm306456ejb.29.2024.02.07.07.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:12:52 -0800 (PST)
Date: Wed, 7 Feb 2024 16:12:51 +0100
From: Andrea Righi <andrea.righi@canonical.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org,
	"Cc: Frederic Weisbecker" <fweisbec@gmail.com>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <ZcOd849l1at2742K@gpd>
References: <6a2b6857-57e7-4321-adae-132ba69a4fff@paulmck-laptop>
 <0e15e91e-da47-45dd-b7de-7f89b7b6002b@joelfernandes.org>
 <ZbieCjYk8cIgZS8L@gpd>
 <cf1c60fc-6295-402e-b546-6f67cf0955b2@paulmck-laptop>
 <ZbjYSXhIrVyCpRNM@pc636>
 <ZbjdL04k2Z2ZdUyp@gpd>
 <b8d80604-18a5-4f82-b846-5c00c6aeae6f@paulmck-laptop>
 <ZcJxhoNpkTM7LnOr@gpd>
 <92cba6df-01de-4daa-a0cb-5fa92c7374dd@paulmck-laptop>
 <ZcN_zDNXRbbWN_Jc@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcN_zDNXRbbWN_Jc@pc636>

On Wed, Feb 07, 2024 at 02:04:12PM +0100, Uladzislau Rezki wrote:
> > > 
> > > I repeated some tests in a more isolated environment and posted the
> > > results here:
> > > https://discourse.ubuntu.com/t/enable-low-latency-features-in-the-generic-ubuntu-kernel-for-24-04/42255
> > > 
> > > Highlights:
> > > 
> > >  - stress-ng --matrix seems quite unpredictable to be used a benchmarks
> > >    in this scenario (the bogo-ops/s are very susceptible to any kind of
> > >    interference, so even if in the long runs NO_HZ_FULL still seems to
> > >    provide some benefits looking at the average, we also need to
> > >    consider that there might be a significant error in the measurements,
> > >    standard deviation was pretty high)
> > > 
> > >  - fio doing short writes (in page cache) seems to perform like 2x
> > >    better in terms of iops with nohz_full, respect to the other cases
> > >    and it performs 2x slower with large IO writes (not sure why... need
> > >    to investigate more)
> > > 
> > >  - with lazy RCU enabled hrtimer_interrupt() takes like 2x more to
> > >    return, respect to the other cases (is this expected?)
> > 
> > This last is surprising at first glance, but I could be missing
> > something.  Joel, Uladzislau, thoughts?
> > 
> Could you please share the steps how you run "fio" tests?

For short writes I was running something like this (on a 8 cores system):

 $ fio --rw=write --bs=1M --size=32M --numjobs=8 --name=worker --time_based --runtime=300

Larger writes:

 $ fio --rw=write --bs=1M --size=1G --numjobs=8 --name=worker --time_based --runtime=300

Thanks,
-Andrea
