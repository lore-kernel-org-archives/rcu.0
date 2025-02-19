Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937921DF980;
	Wed, 19 Feb 2025 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980820; cv=none; b=aPYAZzuo50dn03OmS+PWvZblDGkpPfOhLfFh4l9+dEqHCeSGpXtLj5XcXD2+vrG5f1caHKd6P96HK9p/5xWgIjmYoVtBNCg6naW3T4tmgC+gxxfWvkz4Q8fgIj1Jsb1VI+1/aZeWaZ2OXjJzNoYkpwIWDEAurg0w/dLth5lpyHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980820; c=relaxed/simple;
	bh=86FKLdBrRSJU/fb0e9dIY3qBu2HykrBbgvF7eeAGAJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/WYv/rIVmT785mwVxj7mkdT4gosdSAL3797FwYxSBsZ99eGtYfjwzCSNZLJla/wQReJwT50LHbB8mP00rcCz4V/eoq34szxMGnwJn382F72l2PMYnky4iGIUhcsMv29+i0pQv2S5CVAcP13d5fe0Qk9WEAYdIRD28mcne7Xdy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwziLFg+; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwziLFg+"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7be8f281714so695464185a.1;
        Wed, 19 Feb 2025 08:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739980817; x=1740585617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xowfHEK7d7ldV64lQxLZTiso3cgJbh7FniDAgbQiTs=;
        b=JwziLFg+ZBXh28sU+mOPXWVis+8oP1XuaKxVyFsmahlkDXQIgA2q7IvCyzZZ/PGMkn
         /2tLcsP1m6BfgaurOQLV02t12AcU4XKrPnOcA+5i3eGmowg4UknIAcm8Tw+swHJpuRY6
         SGV4GFfCqh5Lq1AWPZBEZCrZ1YcjmRkuogTGJAI+xUR1V3aqIjchgSRifaFopDhieMUD
         a8HEjPNb9EpNJqQSIErEIhl7aagha6Y3xpahX5P3Fxhtil2rNBt8RV+yegb7L4xusgMe
         v6TXB/cohZjC2WcLSfWVB04Snis+KPgbCqavWgRKtymOa9nCfxfsc9f9J4p8Hj3wZRjj
         v9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739980817; x=1740585617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xowfHEK7d7ldV64lQxLZTiso3cgJbh7FniDAgbQiTs=;
        b=k5Ek80mqjKWqJQ3RhnSjYShSLlnoWQZs1j/3HNFMyOZp85yJeTQmWYNmUrTSMQ9qJG
         p8UtT+4qpgQzp5ho0+2/NkG7CutQE8tNXJ2QoBk90gTToS2qm9IgHYHRbw1WIQs0ljU7
         OOfZknTuSYP9rmTMMSlFZSV+Ne213Rd47bpOyys792YLecQqZmxdPiEpWxc9OpPnBP+/
         uLOm1cG0hk1CJGjVlz23w0T12uxNqTMedkJRFjoQAxzA+o3Xq+soS1hFj0ASZDlBpcR6
         Lez4T6RBbun+xp/0ojHVwxKkqN+Cs8Y4lfVl9AVcOEOEcOVBHaTAljGrahXVcQdKm/a4
         XcIg==
X-Forwarded-Encrypted: i=1; AJvYcCWApfZdiuRq4deis8KhJdBASYGPYsodWL5qfeBUGI7SeNU2fnjLuIBIAwFmICUHXdA0ilEF@vger.kernel.org, AJvYcCX6uceZh8rsQ/ubZtMDHKYFL8qYDX8wBb5xzIzjA5UTXVVMa2hIT+63N58jEjLly8cFNFbyoDYd2/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBdA436TNXR4YhdhvO3kX59lydWCbb1RDsxRQE0pDDSytZMk7j
	rmKO3yqHu00VMGzLy3MAozBGWynce4ScS28WPWnUAebiS+cYMRqE
X-Gm-Gg: ASbGnctnnDcPzDMoJb1zgHFbXKV/gJYMGckiNYgvLS18ehrgfjsC9kg4FKMpvJ/7eR/
	bdKUR71hvk6sQ5d8B6hvUt+AxfYtKPVwLK2cSHvUucBfinIC0wCz9V/QsMMXmSF1TQv9uLYxMoD
	X/EvAdO8MTCvV4ggZFkE+UYwns0SF8OikGQQm1xkIROKCptNMYHgTG6k8jv4TngGXQ49/a8+Hoj
	fGrLuuY/fDAwLOs9iJlyIcFRawUd9L3XbBPLk9QWLUGikOQAgF3CWiRLtgLMMe7cKfqxCOX2z2m
	JHzq+bO6Vpc8zcYCxPpTlpW7fqQgM6uEkzzEGbN4EfNnTDr4u+P0R0cUg+WKem7auICKGVPL2Es
	VcQXDjQ==
X-Google-Smtp-Source: AGHT+IFyIZGeMELLxH4+gRuW1ReVl3v5h8RimIqkv7kvlSbY2QsaqnnOsCGVJyfarjyVsCjwH1yNVw==
X-Received: by 2002:a05:620a:1986:b0:7c0:791a:6faf with SMTP id af79cd13be357-7c08aa74353mr2821854485a.53.1739980816884;
        Wed, 19 Feb 2025 08:00:16 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b3bf7374sm136188485a.95.2025.02.19.08.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:00:15 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5D6A71200043;
	Wed, 19 Feb 2025 11:00:15 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 19 Feb 2025 11:00:15 -0500
X-ME-Sender: <xms:DwC2Z8mjHQWUXWpZM6CKiApWzYwbNIJAZXWfEskhHrGlJ2tzeLjolw>
    <xme:DwC2Z71uB2LIlTDG7kHSiqLU_V5rGhgIRdVk1B6HjUICaGVyCGz7jAqJDEzAnta-b
    AiiJebVaIRZoAfHmg>
X-ME-Received: <xmr:DwC2Z6pMRF6uXmzNA_Hhb2DhHQiVOt8S0LoMtVH2OuTCxgnaV0_XlxJjJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehrihgthhgrrhgurdifvghihigrnhhgsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvg
    gvrhgrjhdruhhprgguhhihrgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghu
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqughotgesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmmhhpghhouhhrihguvgesghhm
    rghilhdrtghomhdprhgtphhtthhopegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:DwC2Z4nMkN17pl3TR7llDyhfr1HTcK-c74tcRxPGobjdBPwXjNDDsg>
    <xmx:DwC2Z63w-QZRtngEnVBWp-XEC3leaxZ8b6y5cWc55rNHBJwRk9jmUQ>
    <xmx:DwC2Z_uDCe2A3mQar42tGxgq1KNeHExx0vB3gVfJTTZRS2E6HePYHw>
    <xmx:DwC2Z2VFokEsH_S6ZAT07c5UPuG8Wq_e5fIvAyaTx0jGe5NDcLVWmw>
    <xmx:DwC2Z90WPVQdSc9jakINUMBMcCqG-zkDrr-LDbezkyZZ2BhMrCsr96Yf>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 11:00:14 -0500 (EST)
Date: Wed, 19 Feb 2025 08:00:13 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	rcu@vger.kernel.org, linux-doc@vger.kernel.org,
	Alan Huang <mmpgouride@gmail.com>
Subject: Re: [Patch v2] doc/RCU/listRCU: refine example code for eliminating
 stale data
Message-ID: <Z7YADfJ7OEJKB_zk@Mac.home>
References: <20250218005047.27258-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218005047.27258-1-richard.weiyang@gmail.com>

On Tue, Feb 18, 2025 at 12:50:47AM +0000, Wei Yang wrote:
> This patch adjust the example code with following two purpose:
> 
>   * reduce the confusion on not releasing e->lock
>   * emphasize e is valid and not stale with e->lock held
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Boqun Feng <boqun.feng@gmail.com>
> CC: Alan Huang <mmpgouride@gmail.com>
> 

Alan, could you take a look and if all looks reasonable to you, maybe a
Reviewed-by or Acked-by? Thanks!

Regards,
Boqun

> ---
> v2:
>   * add the missing parameter *key
>   * make function return struct audit_entry
> ---
>  Documentation/RCU/listRCU.rst | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
> index ed5c9d8c9afe..d8bb98623c12 100644
> --- a/Documentation/RCU/listRCU.rst
> +++ b/Documentation/RCU/listRCU.rst
> @@ -334,7 +334,7 @@ If the system-call audit module were to ever need to reject stale data, one way
>  to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to the
>  ``audit_entry`` structure, and modify audit_filter_task() as follows::
>  
> -	static enum audit_state audit_filter_task(struct task_struct *tsk)
> +	static struct audit_entry *audit_filter_task(struct task_struct *tsk, char **key)
>  	{
>  		struct audit_entry *e;
>  		enum audit_state   state;
> @@ -346,16 +346,18 @@ to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to
>  				if (e->deleted) {
>  					spin_unlock(&e->lock);
>  					rcu_read_unlock();
> -					return AUDIT_BUILD_CONTEXT;
> +					return NULL;
>  				}
>  				rcu_read_unlock();
>  				if (state == AUDIT_STATE_RECORD)
>  					*key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
> -				return state;
> +				/* As long as e->lock is held, e is valid and
> +				 * its value is not stale */
> +				return e;
>  			}
>  		}
>  		rcu_read_unlock();
> -		return AUDIT_BUILD_CONTEXT;
> +		return NULL;
>  	}
>  
>  The ``audit_del_rule()`` function would need to set the ``deleted`` flag under the
> -- 
> 2.34.1
> 
> 
