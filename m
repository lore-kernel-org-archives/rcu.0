Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459941DA30B;
	Tue,  2 Jul 2024 23:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719962439; cv=none; b=L71GPbRRBJ2bIdQHZkxxIwGjUp6G+8PP4sbQrB3M+AwqBhssTjsBWHKcrs5a61t8QmK+MKmxrr2ypruxJIFUvFKRHupjgV+Z7Ulhezpq6O2R+WB3xcsfK9YgH83a4MaiyU0cEONksEJJaQaGBvJb+xBvMviWN5yh1IH74c7rPHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719962439; c=relaxed/simple;
	bh=bpyJm8lxbDc2q85IMQqnT9fTV06FGhkC9f0cwxjqP4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1gWpZMh2JLcJhORhAut/6/eEQcHdIrz0DoJlq7YgW1PzKWTCgy4Hxy4R+SIYYeUUInIJ0z9WkD4g1Sd0L1R2dggjvgb05e1aLDtPBJ3Q6GotCVfIOcnPuHrMY7ZQ+LxI1cZnGRpn++jSLRpnn1epe+/zmZNAAWlzzQE71Gj8RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRtUbb+y; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRtUbb+y"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-79d5e61704eso288530285a.3;
        Tue, 02 Jul 2024 16:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719962437; x=1720567237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjSB7hLGu+RSjy1F3pz8TY7vKbIQRE/DZkSdMM026z4=;
        b=BRtUbb+ykfZUrSEL9umUEI2KM8eFl2huOCL6QKKvDeiNvAWzXGEOVmftj4ApJDzSvr
         Ksq2AljB56Mseqqdgv4hY3ZqiCyofKA9DTgOcpmRGmF1H9GI81egtkhDZ5PJQ+gLHy0P
         mQBUm3f/2MGndCZe6zIxvqymawbDa9vQwiyGhmbEyEVWGgPAJ1oeYf7YYX0m/pHxbVUT
         KRLQjhrLtAzQkK1yC5S3eLZAju1eFCDilrLZH9hCCooWiSOmdPwH1+C6Gdf8fyD1tpDJ
         toI8qqlLNHgwrmXMhfG1Kg9EQVAqse+nRJ+Cu3WseLuTMHwdq1upAs072ZP+5BrlBgP/
         TBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719962437; x=1720567237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjSB7hLGu+RSjy1F3pz8TY7vKbIQRE/DZkSdMM026z4=;
        b=Z8bQtUlFdUfUJ+cEDPlr6F545pH825GaHjpFy27n9ZSh3mKdr5WtAke90Wm0nnKelN
         I13LNixzJA4R7sTbGaPiliPo+img062rNMBPryfy3F7ADwzhaZc6b2jhyl+pV0QvxSiS
         1G+ENV4DBG3Df1loSc8cJHbXv9mLKjkPsPUs0HOwM+HwxlEk6qx3BRookl1h9hdh7VoP
         x0lwfwYdZWF4VfXCHaupgpyXzz72B8UMpnN2e6k70Aed/rlZI+BKOo/3WR6WNSJXgi/h
         4N38KiCN/ilp9awamgaE5iGdCDH+bBhvMAQG3ChEIQ9iX73m0iB7yt/Pnguq1rEf/BhJ
         VTBw==
X-Forwarded-Encrypted: i=1; AJvYcCV94uduIReQ2U33+aWaJxvA2JtPP24M+WE+kFnGh7+1Wr7+mgzGFb4SPaMiMRyRPBoUzK4KjwJ1XKNt/2Q4+qzB49r7
X-Gm-Message-State: AOJu0YxUAInSwhDg1EyV2FeGtv/lxyqS4v+4ot1bMVod0Sg1/SVUMSgf
	oYluTSbLOWmrkUQXV83vELIVXnvpII6gctzr+WfqBXFquPH9TlAl
X-Google-Smtp-Source: AGHT+IFqzoEArcUNqIvbViixR0/Meat25i/cKIFz+5YuJrxKNDABNkuzD0s7fM8Q0BGMt4VIrPUnhw==
X-Received: by 2002:a05:620a:558c:b0:79d:5ff2:c39f with SMTP id af79cd13be357-79d7b9f1ae6mr1024818185a.33.1719962437039;
        Tue, 02 Jul 2024 16:20:37 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-446641f7ea9sm31907881cf.26.2024.07.02.16.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 16:20:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id E59071200043;
	Tue,  2 Jul 2024 19:20:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 02 Jul 2024 19:20:35 -0400
X-ME-Sender: <xms:Q4uEZkm1NoVNEzPbXq1ErwORQiyzbDwEcx2609ZDvYOtecv3mJJSGQ>
    <xme:Q4uEZj3ibJSoHOF4lwGlkl84Wql-RZFMkmzQHZahWdWrVRp6HLFDEBmKLQy6nSTLu
    NEO_f56Kw2abOV4sQ>
X-ME-Received: <xmr:Q4uEZip6O3MXqtdMwvkodohl1UPEdpKFgwl_wVuBubL7fQzOHkrWcCN1B8ql1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeigddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Q4uEZgkssM8md12s09nu65YHtUX9VLe3_B3-2PzXgwYlP3HT-ZVrIA>
    <xmx:Q4uEZi2aIliUa_2ftBtkVeX8INBfqEgu-NUlQ4dkFbrffLoWdv8IQw>
    <xmx:Q4uEZnuvokUU2BBYKMWHgqW8Rg8D-DOP9XaS7i54A4CLUkgyix6Ydg>
    <xmx:Q4uEZuXK7rFTGA7BZR3APzjhXMxCgnB5gQsE0EbwuSJqFURlm4-atA>
    <xmx:Q4uEZl3uwvaVGiM1iLnQ_8eaka8t8oVN4wQwMFZabcdrk9LMSKke863z>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jul 2024 19:20:35 -0400 (EDT)
Date: Tue, 2 Jul 2024 16:19:36 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 11/11] rcu/nocb: Simplify (de-)offloading state machine
Message-ID: <ZoSLCHWKXAOvd5Zl@boqun-archlinux>
References: <20240530134552.5467-1-frederic@kernel.org>
 <20240530134552.5467-12-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530134552.5467-12-frederic@kernel.org>

On Thu, May 30, 2024 at 03:45:52PM +0200, Frederic Weisbecker wrote:
> Now that the (de-)offloading process can only apply to offline CPUs,
> there is no more concurrency between rcu_core and nocb kthreads. Also
> the mutation now happens on empty queues.
> 
> Therefore the state machine can be reduced to a single bit called
> SEGCBLIST_OFFLOADED. Simplify the transition as follows:
> 
> * Upon offloading: queue the rdp to be added to the rcuog list and
>   wait for the rcuog kthread to set the SEGCBLIST_OFFLOADED bit. Unpark
>   rcuo kthread.
> 
> * Upon de-offloading: Park rcuo kthread. Queue the rdp to be removed
>   from the rcuog list and wait for the rcuog kthread to clear the
>   SEGCBLIST_OFFLOADED bit.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
[...]
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 24daf606de0c..72a2990d2087 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
[...]
> @@ -1079,29 +1080,14 @@ static int rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
>  		 * but we stick to paranoia in this rare path.
>  		 */
>  		rcu_nocb_lock_irqsave(rdp, flags);
> -		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_KTHREAD_GP);
> -		rcu_nocb_unlock_irqrestore(rdp, flags);
> +		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_OFFLOADED);
> +		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
>  

Dropping rdp->nocb_lock unconditionally means we are the holder of it,
right? If so, I think we better replace the above
rcu_nocb_lock_irqsave() with raw_spin_lock_irqsave().

Regards,
Boqun

>  		list_del(&rdp->nocb_entry_rdp);
>  	}
> +
>  	mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
>  
> -	/*
> -	 * Lock one last time to acquire latest callback updates from kthreads
> -	 * so we can later handle callbacks locally without locking.
> -	 */
> -	rcu_nocb_lock_irqsave(rdp, flags);
> -	/*
> -	 * Theoretically we could clear SEGCBLIST_LOCKING after the nocb
> -	 * lock is released but how about being paranoid for once?
> -	 */
> -	rcu_segcblist_clear_flags(cblist, SEGCBLIST_LOCKING);
> -	/*
> -	 * Without SEGCBLIST_LOCKING, we can't use
> -	 * rcu_nocb_unlock_irqrestore() anymore.
> -	 */
> -	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> -
>  	return 0;
>  }
>  
[...]
