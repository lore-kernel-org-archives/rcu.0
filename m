Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2800484FAD
	for <rcu@vger.kernel.org>; Thu, 24 Apr 2025 06:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745477663; cv=none; b=aDo8/pF08UkCaqXwG5lCdJ9p4VMtVB7XXGE63IM9rzYZgbRfzHzgFF51zBP+LMWeCRenRtf3KNcwUSmDqqXcB7ZMsxqoCErowLcfwGLco/M5VorjBr0R9PnJ2Vo/6Hjrn+jsEyIFQRY3daVPeAxF/qIYAwjAKVuxs8pwaBsIBWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745477663; c=relaxed/simple;
	bh=qpciELgxd5Qe1ngB2F47Jr5rLG28E8lJWaMsftigVqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/nWTloxxv3g4QCyqMtdzYVY40SVCCKmAf2MP41GJv6BblA9xe6CcdtE9Rx3j6NL3DmP9Yq4275A/c5nTQ3+XBYQZK7mlX6xbZhs+ppDXhPdrApWVmU0ZlGfpgjIiz9k6IXoCh/32rqLvQ1FBDuNpYcf4D+XFgG+WGBkk+ToS/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pVwZ7Zv2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pVwZ7Zv2"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so425262f8f.2
        for <rcu@vger.kernel.org>; Wed, 23 Apr 2025 23:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745477658; x=1746082458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9cz/tyqeda9jqhJA1LM12C4cMq1ea0hahPgYBV7DW/Y=;
        b=pVwZ7Zv2VdtxPeER1r8QtsRf79+1sMo4jE6unGolti88OXFFfTjIiH+j2t+VbRxkH+
         7w3X1a7frajxXBRxaRDbR43eZuyW+vZlw/21hs4WTTBySBwnxrGMliObGOydZC5Xkymy
         Hi0l6ujQZXMHp885Ag96xSyDsB2N6wBQU+xMoUuWs401dQu7RURwpGfKHhpPfRWrrBai
         bB9vksxKVm3zJXQVB8f28upFPb9zsugS77jeeeAAasVEVUP+D9vzW4TAwkJpq9nlfnPt
         XD3OCOiAT27KDoTTnCS+MW84HA/LNelNMoWqElFajCPu93BnPLwTeN4TPl2/u4bSPGzM
         btjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745477658; x=1746082458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cz/tyqeda9jqhJA1LM12C4cMq1ea0hahPgYBV7DW/Y=;
        b=ZOHm/Af+PTRCiETkr3tzgLwtxev8E8lWNJonOV6MI6ATpo76sCuA0yNOenwUCZGGwI
         /+QzumIgyCWww8dru50pXbNO7bTfPUkdEl/g9lRiwncjG/nOMn2Dbgb9Uku8MTdIypXJ
         mQM0vdk++wDH6YBEirlAh7mx3Pon4iSodhdQChemnZ44gu1Fd2zAkSgG/HZGTadkcP6H
         3QhDgQ40we61AydIIyY7Zx1ZSd78V1zqzng8ALtWNNJ/RTOW4yAXZSO6gSuSr4d6rvDf
         6AK1MNroJMATVGLxBWKWFO1DbzK9PBLFTe/PKkeCHNZPhGYBGKtbBIKDC4nEPEwYVvje
         Iqng==
X-Forwarded-Encrypted: i=1; AJvYcCV4wv53qI0mNFdIcqVHSOkoZEEU5arMLS+2XIH0v4rbMGPj+mXN0qKHWTKJ8tv7p1i47uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRIUrE7k2Jn71FOk/W7mZBJf0cYHVaSPjC2IzEYjaaVQqB6rVQ
	8w/jdBIsksjp2RYH/mGrnDPjLh4I4apCjwHN5QwVAK96zXcOluiT02LE0wkrO8o=
X-Gm-Gg: ASbGncsgh5k+8cMa3payY3xKohUXVlOXj1kIB4oscimF0fyFe8bneBsmzOFGME9n32/
	mMEsUXBxQLDSBAnOuRTWHQ5GVNMPo689K0JMPlVlQ66doMhDpGWGr5YXlHhWOj8r7+5lQ0loToa
	yy63TeV7mzp1rQ5ZtIsgzmbplJcJxvYP9KaVFeh7UyFCA8Ea5rlmlqMSIN69jlYMOaeQ8tLMYLA
	MxiGhvPAI1ZLUYyK36Tnec0aNXDs91Mm0SW1JLvrkJsMAKvcs1yUg49OQzMmS3xoRPWfti0JaWZ
	FiJ9zDPxCm9k2MPTAwwaFpBFOZJrrAnbe7ptphZJnWOa8g==
X-Google-Smtp-Source: AGHT+IHOWRdPMsZUXiGkBaftvT/O71Qm9tNXwu85YfRGgkq/9b+oD14whFdNRpLiU1G5hTaZMmIz/Q==
X-Received: by 2002:a5d:4acf:0:b0:39c:30fc:20 with SMTP id ffacd0b85a97d-3a06cfa3449mr740840f8f.37.1745477658329;
        Wed, 23 Apr 2025 23:54:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a06d54f019sm1040159f8f.96.2025.04.23.23.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 23:54:18 -0700 (PDT)
Date: Thu, 24 Apr 2025 09:54:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, rcu@vger.kernel.org
Subject: Re: [bug report] rcutorture: Perform more frequent testing of
 ->gpwrap
Message-ID: <616131f6-5365-40ee-ab57-27d484077a31@stanley.mountain>
References: <aAiT_KWYN-gP-2MN@stanley.mountain>
 <f8669b6b-63e0-454d-8a58-09043015bc61@stanley.mountain>
 <a2090431-7299-4fc3-89cb-114026f482b1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2090431-7299-4fc3-89cb-114026f482b1@paulmck-laptop>

On Wed, Apr 23, 2025 at 05:41:37PM -0700, Paul E. McKenney wrote:
> On Wed, Apr 23, 2025 at 10:19:56AM +0300, Dan Carpenter wrote:
> > On Wed, Apr 23, 2025 at 10:17:16AM +0300, Dan Carpenter wrote:
> > > Hello Joel Fernandes,
> > > 
> > > Commit bd57ec707441 ("rcutorture: Perform more frequent testing of
> > > ->gpwrap") from Feb 16, 2025 (linux-next), leads to the following
> > > Smatch static checker warning:
> > > 
> > > 	kernel/rcu/rcutorture.c:4586 rcu_torture_init()
> > > 	warn: missing error code 'firsterr'
> > > 
> > > kernel/rcu/rcutorture.c
> > >     4576                 if (torture_init_error(firsterr))
> > >     4577                         goto unwind;
> > >     4578         }
> > >     4579         if (object_debug)
> > >     4580                 rcu_test_debug_objects();
> > >     4581         torture_init_end();
> >                    ^^^^^^^^^^^^^^^^^^^
> > Also:
> > 
> > kernel/rcu/rcutorture.c:4591 rcu_torture_init() warn: double unlock 'global &fullstop_mutex' (orig line 4581)
> 
> You lost me on this one.  This mutex is acquired by the earlier call to
> torture_init_begin(), but only if that function returns true.  If that
> function returns false, yes, it releases fullstop_mutex, but in that case
> rcu_torture_init() returns immediately, thus avoiding this invocation
> of torture_init_end().
> 
> Or am I missing something subtle here?  Or missing something obvious,
> for that matter!  ;-)
> 

I explained it badly.  Joel's patch added a goto so now we call
torture_init_end() twice in a row.

> 							Thanx, Paul
> 
> > >     4582         if (cur_ops->gp_slow_register && !WARN_ON_ONCE(!cur_ops->gp_slow_unregister))
> > >     4583                 cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);
> > >     4584 
> > >     4585         if (cur_ops->set_gpwrap_lag && rcu_gpwrap_lag_init())
> > > --> 4586                 goto unwind;
> > > 
> > > set an error code?

Here is the goto.

> > > 
> > >     4587 
> > >     4588         return 0;
> > >     4589 
> > >     4590 unwind:
> > >     4591         torture_init_end();
> >                    ^^^^^^^^^^^^^^^^^^^

Here is the second torture_init_end().

regards,
dan carpenter


