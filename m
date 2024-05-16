Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A56FD5
	for <rcu@vger.kernel.org>; Thu, 16 May 2024 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879346; cv=none; b=LFYAPCUhOss8OTf3TDLa6cCZMMT2USzdoKwOV8U8VqxHCaA5ImBFGXmQT4cckCHZnK5NAt2mfLZX8lbiwN/J506kHVfKIWEKKY6JbMCuk3/Pqe6GEWewLoijc0DVdkgQJNZmHlZ/4qxUKCluyDy8XPMBxmD3diokYukHedWFjjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879346; c=relaxed/simple;
	bh=0RkmXsdmagNT/bqvcJdAmk0xtpCf8bn2ikSDqEnh4Ok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eZe4nEHUtP9nQEyZ9lkwbT/GC2tp3amFZx5mjXid1KtqW+a9pyqR1iu3zh5EOs8CGjDJtunokjwczfiwK0V2lR09HA1+dojy2V6SpRPfcqwmNGokhx5Gr7LuYS+mBoITK62eFaUeH43lxVSGFiREf6QGFIgF+KezIhNJZ9QVTbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gYc0qgwV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYc0qgwV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715879343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fwl5ijp1WBCjo30K9mEsIIKaqnibqalZoZLPPdp7ItA=;
	b=gYc0qgwVlxpF5B9fwugpaQzoJeelIozNI48hYgSQmo0q/lCEVQ+dD9yym8iJxK/ijAFULJ
	mzDAnRyjBfLoJoRKkIQqiI6r20Dz0wPWPDOB9hm4kxUT9C1f8fR3HkmmTAp1HRiwN0otDG
	jhpSp2uaptLJvJqyhocdbUzOOyGq7kM=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-X0f9_OdkNnyZRL_4-GFzZg-1; Thu, 16 May 2024 13:09:02 -0400
X-MC-Unique: X0f9_OdkNnyZRL_4-GFzZg-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5aa350b43ecso11424625eaf.0
        for <rcu@vger.kernel.org>; Thu, 16 May 2024 10:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715879341; x=1716484141;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fwl5ijp1WBCjo30K9mEsIIKaqnibqalZoZLPPdp7ItA=;
        b=OzdwjXwN9nuETR7dK8TBi3cGmwaVByW5/0sFK0kO1xXbVLl6AAPUBDtv80cNyFovL3
         XgOX4frzkxdQQ1GFhwtLA5GNldeRLjT7AX57PU9HZEwN8sTogxtuWa755MiZ+8FOII1A
         xo9g+tsx0LaYYEDp9B+rasreyVwrPlwL9hH8lu/6lKWD6zGLMboSAAt9PPMRYFajl92V
         GU2JDOdC+P9SxCN95NXL9IMF3vznRmOu5u29Je6zn2Eff1ZKakbTXuDnsekn6jFtEtgg
         xK9wbi2NkN9ao8CYLYXuTdpUjVIEewlnbtksA3r8+0Bi5Il49GHZozsjW2cZIwHiKNKj
         fQbA==
X-Forwarded-Encrypted: i=1; AJvYcCWT9mrp7VL4RMBk+QZadbBU0dUzZiLLCf11wWedOjtk2WzBPEwcu1FhuIMQ+YcFOrB/oQWIj0BPE66B+p8ckE/nURX0
X-Gm-Message-State: AOJu0Ywmru/f82kbyE38MOpuJlYHIXffHUwRXoiLSL4wKbSkXsDAZPNz
	arDO6u/d76BeJMxBNEOOUvtN9dUosMkHIF9tJX3NRpYAXutg4qco+GxMzoH3IQSoZ6J69g2qcu8
	nnJHq5UdMVnT+4Kr4Zd4FCVBnJqJdjOMiNwHlGlPGWbNizdLxcjTJA0keJlmI0Oa1kXqFvUHy1+
	NqPUl1traRs10Uk/ZW8hWJQVEWDq4TljDO6w==
X-Received: by 2002:a05:6358:9046:b0:186:1193:8ccd with SMTP id e5c5f4694b2df-193bcfc6725mr1960430355d.23.1715879340623;
        Thu, 16 May 2024 10:09:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbR9sotsDlG5zEk2F6Q014ne8oUaPeHc9v6+ESt7ttYxIzzBZgH7l1uMJKpf4WeEOvhpBcvA==
X-Received: by 2002:a05:6358:9046:b0:186:1193:8ccd with SMTP id e5c5f4694b2df-193bcfc6725mr1960426155d.23.1715879340060;
        Thu, 16 May 2024 10:09:00 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a346a382ffsm33422646d6.10.2024.05.16.10.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:08:59 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes
 <joel@joelfernandes.org>, Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/6] rcu: Remove superfluous full memory barrier upon
 first EQS snapshot
In-Reply-To: <ZkYvemdrEOVFNtVu@lothringen>
References: <20240515125332.9306-1-frederic@kernel.org>
 <20240515125332.9306-3-frederic@kernel.org>
 <xhsmhfruhhixv.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <ZkYvemdrEOVFNtVu@lothringen>
Date: Thu, 16 May 2024 19:08:57 +0200
Message-ID: <xhsmha5kphefq.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 16/05/24 18:08, Frederic Weisbecker wrote:
> On Thu, May 16, 2024 at 05:31:40PM +0200, Valentin Schneider wrote:
>> On 15/05/24 14:53, Frederic Weisbecker wrote:
>> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> > index 58415cdc54f8..f5354de5644b 100644
>> > --- a/kernel/rcu/tree.c
>> > +++ b/kernel/rcu/tree.c
>> > @@ -773,7 +773,12 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
>> >   */
>> >  static int dyntick_save_progress_counter(struct rcu_data *rdp)
>> >  {
>> > -	rdp->dynticks_snap = rcu_dynticks_snap(rdp->cpu);
>>
>> So for PPC, which gets the smp_mb() at the lock acquisition, this is an
>> "obvious" redundant smp_mb().
>>
>> For the other archs, per the definition of smp_mb__after_unlock_lock() it
>> seems implied that UNLOCK+LOCK is a full memory barrier, but I wanted to
>> see it explicitly stated somewhere. From a bit of spelunking below I still
>> think it's the case, but is there a "better" source of truth?
>>
>>   01352fb81658 ("locking: Add an smp_mb__after_unlock_lock() for UNLOCK+BLOCK barrier")
>>   """
>>   The Linux kernel has traditionally required that an UNLOCK+LOCK pair act as a
>>   full memory barrier when either (1) that UNLOCK+LOCK pair was executed by the
>>   same CPU or task, or (2) the same lock variable was used for the UNLOCK and
>>   LOCK.
>>   """
>>
>> and
>>
>>   https://lore.kernel.org/all/1436789704-10086-1-git-send-email-will.deacon@arm.com/
>>   """
>>   This ordering guarantee is already provided without the barrier on
>>   all architectures apart from PowerPC
>>   """
>
> You seem to have found the accurate informations! But I must admit
> they are hard to find and it would be welcome to document that properly, for example
> in Documentation/memory-barriers.txt
>
> I think the reason is that it's not supposed to be used outside RCU, perhaps
> because its semantics are too fragile to use for general purpose? Even that
> could be stated along in Documentation/memory-barriers.txt
>

That's also what I suspected when I stumbled on

  12d560f4ea87 ("rcu,locking: Privatize smp_mb__after_unlock_lock()")

which removed the references to it from Documentation/memory-barriers.txt

> Another thing is that its semantics are similar to smp_mb__after_spinlock()
> (itself badly documented), although slightly different. I'm not even completely
> sure how. I assume that smp_mb__after_spinlock() can be just used once to
> produce the required ordering and subsequent lock on that spinlock don't need
> to repeat the barrier to propagate the ordering against what is before the
> smp_mb__after_spinlock. However IUUC smp_mb__after_unlock_lock() has to be
> chained/repeated on all subsequent locking of the spinlock...

IIUC (big if) the chaining is a requirement of RCU itself, per:

  2a67e741bbbc ("rcu: Create transitive rnp->lock acquisition functions")

   * Because the rcu_nodes form a tree, the tree traversal locking will observe
   * different lock values, this in turn means that an UNLOCK of one level
   * followed by a LOCK of another level does not imply a full memory barrier;
   * and most importantly transitivity is lost.
   *
   * In order to restore full ordering between tree levels, augment the regular
   * lock acquire functions with smp_mb__after_unlock_lock().

