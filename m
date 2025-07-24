Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB83C1DFE0B;
	Thu, 24 Jul 2025 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378623; cv=none; b=SkIvDlj9bMS3ZlhkrnMUsm9UlXrALqB/eV5YS0Vtor/JolHtezaMfJA6ua/XjqAODYdMEIO3r0ByZ/9FNU51kJoxevCV33qKtJkT/x5jGdB4DpJJw/+d8JzDTmBceLG3ajx5jlFPM0U8jALLyT4CCh1XbW0lZ51oCqt7yPEKq+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378623; c=relaxed/simple;
	bh=HV6X+Wq063Ubgqw5UZkXeD+Lotlatxd7ATFDPIMPXOg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dybR8U/gtmDD534tlsv9FsdHEJeza1etqUaqIRRQES3NrfC+RU8GfapppFypzMZ0O5WD7I1Bfhx05Aac3t3R6PzJc5H4/C2BwOIPh/qD0tVXW3MGVe7FVHrAUzJw6m93u3PNtMruDnekKhmFz/li4kjvZcvYBtnZrfRedjh6XY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faMsSSG3; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faMsSSG3"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55502821bd2so1430496e87.2;
        Thu, 24 Jul 2025 10:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753378620; x=1753983420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u+0psVHngmmkd6BNaJj165FgVIaF52MaA8fovNqmaAQ=;
        b=faMsSSG3YNMBjroDx1SJi4rDSe/3jIes6Y0Nlh8pyQUkpmXLgGuKSlq9QIP5Lhrb7Q
         27vgzAINlM62CFvAekliHAsNk5ED0c2Tu10dEBWog7IUjxtiPEr5EKWDKVwA4nQ5oUNf
         bF1jpQYFIzM2ACVl8XY9RTEUgE9jPD9vcGz80n8WOfo3rpJNpdVViJYfK8d2bCDi9+qI
         eKLwQZLtzUqAbdLDLyTEc00c3QbyPT37zbf/OaEnWyL0yvSEsOvPMwVuWV9nxlFVutVL
         iMdS+FOm6b7KYFiKLoJVdJDTCnuwZyy1Tt+vHCPn83tvIE3AQIr29DV9T3a78RHZjV/o
         pYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753378620; x=1753983420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+0psVHngmmkd6BNaJj165FgVIaF52MaA8fovNqmaAQ=;
        b=j3DmVwiVbRILoAEd0ePvEFjRAV3Q7AgXaIeu+tsoOyLNNgOP+lv1Cm6GqNLwzdqOLY
         HQ/hmCsRUX5iv7GjC9sWgvGD0otLEto0CnDVd+gp13rQ6Pu582xTErVDNd/UIdjKVYpt
         qOsFKnYxjzN03Ci7suakgRqPNyFRFEOjpubrmYCbJzK0PgRbDGryci9Y1HiDjaqx6WqG
         0mGf5wDHFSg6Hhp+7W7b2lDMl5Z1N3w+c5v4LG8EsPuCuLmVG/xX3uW/y9yq8DAYCxtx
         lD8rCtK4rzEJQaQWrMz80gbuhoQ0xDDUeeibpQuLse1ZzXQccBZrz/BEFf9l3PPPPO29
         Upag==
X-Forwarded-Encrypted: i=1; AJvYcCU5psw6bMLV0yn46+1xafIMWGc0AmKN7+jxC7xkyJ0o8uChSj145gzi4HxXILqrQCCU5zr3cjh8BykXF8U=@vger.kernel.org, AJvYcCVAZ/JagPoDn5f6YBPFrG29I2p01sp+aTWDSjpbcaHhs/asTLD2k/tBHB0W39kvz48oLCMq@vger.kernel.org
X-Gm-Message-State: AOJu0YxGLX6mpc3Q+XSa8Eem7m1VLi/ew59iFt0M398zk/m2WoJAa9Ca
	RSqcdtJREd9o8wTOrsJFv4SL4JvrQ35N9KrlXuy+UYmBpOKJTEC7JO/C
X-Gm-Gg: ASbGnctkegWDd/8CUxihqaH6zULngsaLUvoPoFl0nCqZmryUMzERumfh+rSitnSLaIk
	yeAt1QU6NMQRdaWzLzax25Y3s86ft09dr6RO3GJ1N24bVDia/gYWTWagrVKUMCJmfrQXhVk90ir
	VPhDGvOkKh8DudC1woLjR4Pq7XuVliGmD7zsuvhj3iXr6dMOaJJsE36PiAQc6yjVAZ8fQSlqmHW
	cWFago2txs7NlTeB9I7XaXkNT9jnyoTIL0GArvP8OxjpjgzT6I7jxr2uNcNs87k3mQcIjF9kBxM
	xUPwC5iB5u+KMVMEI5ITi8XyLrsHdQLoSIBX3uuSZE9jtl85gUDchiVodFgzKNqBGkSLKLHUw7R
	WVfA5PhZMh1w52/HCnVNO7R6bodA2Lxyt8/EZGRIRRKejIpHhBw8j
X-Google-Smtp-Source: AGHT+IFJ0U7TkNADQ2AfHDBSDKSrNM+CuHEwo6+dh7Yi/pvc6GyK1HnMSXZ+oyUuzgfWZ9O/y6V/sQ==
X-Received: by 2002:a05:6512:1104:b0:553:2c65:f1d1 with SMTP id 2adb3069b0e04-55a5137e065mr2015821e87.13.1753378619517;
        Thu, 24 Jul 2025 10:36:59 -0700 (PDT)
Received: from pc636 (host-90-233-212-206.mobileonline.telia.com. [90.233.212.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b5b348ab3sm25610e87.53.2025.07.24.10.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 10:36:58 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 24 Jul 2025 19:36:56 +0200
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: Re: [PATCH v5 02/14] slab: add sheaf support for batching
 kfree_rcu() operations
Message-ID: <aIJvOLqljFiN_VLR@pc636>
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
 <20250723-slub-percpu-caches-v5-2-b792cd830f5d@suse.cz>
 <aIEQQ0MW5e8KMvVL@pc636>
 <9cad7b86-4b77-4881-9cbf-637b6a61695d@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cad7b86-4b77-4881-9cbf-637b6a61695d@suse.cz>

On Thu, Jul 24, 2025 at 04:30:49PM +0200, Vlastimil Babka wrote:
> On 7/23/25 18:39, Uladzislau Rezki wrote:
> > On Wed, Jul 23, 2025 at 03:34:35PM +0200, Vlastimil Babka wrote:
> >>  static bool
> >>  need_offload_krc(struct kfree_rcu_cpu *krcp)
> >>  {
> >> @@ -1952,6 +1973,9 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
> >>  	if (!head)
> >>  		might_sleep();
> >>  
> >> +	if (kfree_rcu_sheaf(ptr))
> >> +		return;
> >> +
> >>
> > I have a question here. kfree_rcu_sheaf(ptr) tries to revert freeing
> > an object over one more newly introduced path. This patch adds infra
> > for such purpose whereas we already have a main path over which we
> > free memory.
> > 
> > Why do not we use existing logic? As i see you can do:
> > 
> >    if (unlikely(!slab_free_hook(s, p[i], init, true))) {
> >         p[i] = p[--sheaf->size];
> >         continue;
> >    }
> > 
> > in the kfree_rcu_work() function where we process all ready to free objects.
> 
> I'm not sure I understand. In kfree_rcu_work() we process individual
> objects. There is no sheaf that you reference in the code above?
> Or are you suggesting we add e.g. a "channel" of sheaves to process in
> addition to the existing channels of objects?
> 
There is no that above "sheaf" code. I put it just for reference.
I suggested to put such objects into regular existing channels and
process them. But for that purpose we need to check each SLAB object 
because currently we can free them over kfree_bulk().

A separate channel can also be maintained but it would add more logic
on top but at least it would consolidate the freeing path and use one
RCU machinery.

From the other hand what else can we free? You have a code in your patch:

	if (is_vmalloc_addr(obj))
		return false;

	folio = virt_to_folio(obj);
	if (unlikely(!folio_test_slab(folio)))
		return false;

vmalloc pointers go its own way, others are SLAB. What else can it be?
i.e. folio_test_slab() checks if obj->folio is part of the SLAB objects.
Can it return zero?

> > I mean, for slab objects we can replace kfree_bulk() and scan all pointers
> > and free them over slab_free_hook().
> 
> The desired outcome after __rcu_free_sheaf_prepare() is to take the whole
> sheaf and have it reused, not free individual objects. So we call
> slab_free_hook() in __rcu_free_sheaf_prepare() but don't actually free
> individual objects as necessary.
> 
I see.

> > Also we do use a pooled API and other improvements to speed up freeing.
> 
> It could be useful to know the details as in Suren's measurements there's
> issues with kfree_rcu() using sheaves when lazy rcu is used. Is the
> kfree_rcu() infra avoiding being too lazy somehow? We could use the same
> techniques for sheaves.
> 
I think, it is because your patch uses call_rcu() and not call_rcu_harry().
There is one more tricky part, it is about how long rcu_free_sheaf()
callback executes, because there are other callbacks in a queue which
can wait its time.

kfree_rcu() infra does not use call_rcu() chain because it can be slow.
We can delay a process of freed objects if an array of pointers is not
yet full. When a first object is added we arm the timer to kick the
process in 5 seconds. Once an array becomes full the logic switches into
a fast mode, reprogram a timer to trigger a process asap.

Also, this patch creates a collision because it goes its own way. We
have a kvfree_rcu_barrier() which becomes broken if this patch applied?

--
Uladzislau Rezki
