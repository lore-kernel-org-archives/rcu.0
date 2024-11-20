Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C1D1A0BDC;
	Wed, 20 Nov 2024 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732106259; cv=none; b=NkkQYXAxcsXMhhE6yNnXqMrFVjteh3soYz1bSvvddsSUhU1hR1VHTbojXF6gcZziAd97pK5/XnZzFDvZ9ICCDycxwKcX1ELvuUVLIlKf6I3o2HUOsbSOAE10a/CEWrhc5/LcMJzcU+5fAl/cmn0ILuO78zld6tqjNmev6HPDVjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732106259; c=relaxed/simple;
	bh=VLhxafoNO0znCZ3Uhc3pmmStvgn3oE4jBd11+51x2TA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOXMwUpA+TypGdWIxdq1ODIBepLje6sRN807P/o6bJCMLvTR0JS3c+cpJI262J2Fy4TdpMEMT9lWHdvjjMJAwcBdOnqfLB8g4kkuvdLhZOPU3wt0HfLpbZcC9/OsXzbdf/MnoinNVaPpNxwWB8FomEYVeftl9+ghmH5T7a49mOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djuEer48; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djuEer48"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so39475981fa.2;
        Wed, 20 Nov 2024 04:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732106256; x=1732711056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0OQRfg1x8SRZX/1jAroPcUFCgz+iCdQigYI/A0qZro=;
        b=djuEer4837EKMl3X1E/ZBndU3ZHLGnrFe1biC5qSJtaY8oiDml16Hj7wGV/NXJQo4e
         xVmvlvFWF13KYcUIxBlOCS2Ys65DHNpU992peYem2GlRaJsrLysL5JT4A3ExrMRMHxXN
         fqOci1pIbVMDLpGahmWfyLMqW4cU7YzrpPc54JVTboKR3EC+CuDoNtm5WlrQPzTYwln6
         Ocbg/Dlo7Y2JHy06KUtPq43WlhideXEoB/fUAwcQU+DmXqH4tSOl4pgRyGWIq/VlEcJb
         s3mSgz5kWt8d4pzpOW8xcbzJbUFrIFVCBlCV018+rCf99wiG+8UmS4C5U4zpMDSAWm6c
         5tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732106256; x=1732711056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0OQRfg1x8SRZX/1jAroPcUFCgz+iCdQigYI/A0qZro=;
        b=BLNmAUfAYgZF7ljq2I8s6PNXxWHCGK9sy9bRXfdtixnh0jgnlD3vRX1ugEbgEetkqi
         kiVULp125704SayACvJJeZzQzeLAZyocuNJUteG+HhlnfAGvt6go2+fD2sypQcyA+L7p
         hkD4YqnbFY5VkhzYHSAg/5iGFVKeM0Qhf29DAA8k4uTTcHcRbE+FyOh4Cy0wxUjKFawF
         36h8fTA+lyRZ0cs+CuujeomJC7ebq8G3emM9iYomHmQV7tJlyTRJZtWCQ6oRRmZIgR0k
         lpB/yfAvBDBBGROvLl2jl0Ck+crPR96hzthrtc3aEfcIh1FhtuzwJrg+0BwLJk0FOYaW
         j++w==
X-Forwarded-Encrypted: i=1; AJvYcCVXJ7VKkwc5AAqKlQLSF/PIgH8qyw5YAYb3zherow2i1mCnxmH2uO59Gj3uqe/SXilM4G7KopH4OnCIgbg=@vger.kernel.org, AJvYcCWDN8fJrT7nE84PRhdFqZecR5WUTDpW+duMZ7zWRqCZzqxra20kfD0TcPQa3E7p/dRNeXdg@vger.kernel.org
X-Gm-Message-State: AOJu0YwR7wvRmFcdT8x/ZgCYJ1kHZAftzl5/505Rs4VbmFWnxiTIj9QD
	zmVQtDxpAiC0AsMUsRBuq0KtBvSx3MXCTFOqy5lSVXog8I2zv8AE
X-Google-Smtp-Source: AGHT+IGi2eyxJ/gZkhAlHUIa5j3A5ZbuPIrKPcSGhNJMGHq34OncnDqR74dznOsVAJDkagm6V1CM6g==
X-Received: by 2002:a05:651c:515:b0:2ff:5c17:d572 with SMTP id 38308e7fff4ca-2ff8dc8a711mr15098011fa.22.1732106255718;
        Wed, 20 Nov 2024 04:37:35 -0800 (PST)
Received: from pc636 (host-95-203-8-230.mobileonline.telia.com. [95.203.8.230])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff69959c68sm15070981fa.44.2024.11.20.04.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 04:37:34 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 20 Nov 2024 13:37:32 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC 2/6] mm/slub: add sheaf support for batching
 kfree_rcu() operations
Message-ID: <Zz3YDI4Bb04opI2d@pc636>
References: <20241112-slub-percpu-caches-v1-0-ddc0bdc27e05@suse.cz>
 <20241112-slub-percpu-caches-v1-2-ddc0bdc27e05@suse.cz>
 <ZzYsBu_rJWSAcAYf@pc636>
 <cc7f24b8-4de5-4023-b40b-5f62287aafe8@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc7f24b8-4de5-4023-b40b-5f62287aafe8@suse.cz>

On Sun, Nov 17, 2024 at 12:01:01PM +0100, Vlastimil Babka wrote:
> On 11/14/24 17:57, Uladzislau Rezki wrote:
> > On Tue, Nov 12, 2024 at 05:38:46PM +0100, Vlastimil Babka wrote:
> >> --- a/kernel/rcu/tree.c
> >> +++ b/kernel/rcu/tree.c
> >> @@ -65,6 +65,7 @@
> >>  #include <linux/kasan.h>
> >>  #include <linux/context_tracking.h>
> >>  #include "../time/tick-internal.h"
> >> +#include "../../mm/slab.h"
> >>  
> >>  #include "tree.h"
> >>  #include "rcu.h"
> >> @@ -3420,7 +3421,7 @@ kvfree_rcu_list(struct rcu_head *head)
> >>  		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
> >>  
> >>  		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
> >> -			kvfree(ptr);
> >> +			__kvfree_rcu(ptr);
> >>  
> >>  		rcu_lock_release(&rcu_callback_map);
> >>  		cond_resched_tasks_rcu_qs();
> >> @@ -3797,6 +3798,9 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
> >>  	if (!head)
> >>  		might_sleep();
> >>  
> >> +	if (kfree_rcu_sheaf(ptr))
> >> +		return;
> >> +
> >>
> > This change crosses all effort which has been done in order to improve kvfree_rcu :)
> 
> Yeah I know, but it wasn't intended to make it all obsolete as I don't think
> every kfree_rcu() user would have a sheaf-enabled cache.
> 
> > For example:
> >   performance, app launch improvements for Android devices;
> >   memory consumption optimizations to minimize LMK triggering;
> >   batching to speed-up offloading;
> >   etc.
> 
> Yes it's a great effort that I appreciate and you did probably all that was
> possible to do without changing the slab allocator itself.
> 
> > So we have done a lot of work there. We were thinking about moving all
> > functionality from "kernel/rcu" to "mm/". As a first step i can do that,
> > i.e. move kvfree_rcu() as is. After that we can switch to second step.
> 
> Yeah we have discussed that with Paul at LSF/MM as well and I agreed it
> makes sense, but didn't get to it yet.
> 
> > Sounds good for you or not?
> 
> Sounds good, thanks!
> 
Thank you. Let me try to start moving it into mm/. I am thinking to place
it to the slab_common.c file. I am not sure if it makes sense to have a
dedicated file name for this purpose.

Anyway, share your view if you want to add something. Otherwise i can
proceed with that process.

--
Uladzislau Rezki
