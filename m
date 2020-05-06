Return-Path: <SRS0=3e4L=6U=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F16C28CBC
	for <rcu@archiver.kernel.org>; Wed,  6 May 2020 18:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F3BC206D5
	for <rcu@archiver.kernel.org>; Wed,  6 May 2020 18:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2G2eQWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgEFS3K (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 May 2020 14:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729313AbgEFS3J (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 May 2020 14:29:09 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E296C061A0F;
        Wed,  6 May 2020 11:29:09 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 188so2186848lfa.10;
        Wed, 06 May 2020 11:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8uFfjmJQ34Ru3+2rUtoTfL18MZiFWub+orW6ZjEFZRo=;
        b=B2G2eQWb2vvv7fGShDkInZMoYpb5intPAkogP/WM+B1lyOz6hgaR+2isDwT+Ua0RGs
         DKUjdW3hd7Czozq5VmF6WA8w0ETsyD4juwlKXUWM0HhHJTybEaISjD+NSDPKKb5WM8P0
         gwGQdM2F3Lt7Rn0B8/F0eFcTyRJWxvESRPSiGUj8KW0ON6nQbK+ZXVCrRhlpWrF4/Tfj
         orT06Ya+LJeldPqwet+suG8UAF7Q513Yt2ugIpkrbTvZZAaSrOzNNoXoi23t8cXH2hHa
         qxlX1m4v/1hDvdNWBbyxD6j4G3mWbCijMhO5wIcvxzL7XBeD7mvMpCpI6xl++o1hEP6c
         nzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8uFfjmJQ34Ru3+2rUtoTfL18MZiFWub+orW6ZjEFZRo=;
        b=prfNsNf5Fks9fc0S48jtbVv8bwfpgY5fM5vSoDPksVEx9xyRzxg6WtlxKftbrWBvr1
         SXoibio06ScwvfDNF0BYLIHOscZAgsxMXIhjz5anit98HN38lOstrNaYR5YH8WNdz6Nn
         eu5eCaKIiSQ5fcoe+ct7ZvjOQpd9rTJ4yjWuDkFxpId+jUL2B8dCQj/vybA/RmRWqFzt
         5PDBtluqXUNaz45aglQ9Di2MJVT1yi4it2H0AgzEb6s2RLVnV12LKS88CcJYf6MxnCVu
         Kvanw8mwanPipRuLQFWQZ6EdIcDCO+XkBJzRgN33JYPWXZtQtDANCWDvphK4blPNP70E
         X0Cw==
X-Gm-Message-State: AGi0PuZkJ8fVC+X9HSDd0tnj2qUQGiciANxec9bO6jvnK1Mqk+9T3/nl
        o4klIzVzgJ5Jtm/k4Ia70WQ=
X-Google-Smtp-Source: APiQypL1LY97fVbP2+jltuM+HvwXjcF4mVPnXUQNAfSzdtg6CT3iunNViZ4JrqjCI8ILfl0mNb58eA==
X-Received: by 2002:a19:5053:: with SMTP id z19mr6231192lfj.177.1588789747650;
        Wed, 06 May 2020 11:29:07 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id x24sm1812474lji.52.2020.05.06.11.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 11:29:04 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 6 May 2020 20:29:02 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 21/24] rcu/tiny: move kvfree_call_rcu() out of header
Message-ID: <20200506182902.GA2570@pc636>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-22-urezki@gmail.com>
 <20200501230359.GH7560@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200501230359.GH7560@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Paul, Joel.

> > Move inlined kvfree_call_rcu() function out of the
> > header file. This step is a preparation for head-less
> > support.
> > 
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  include/linux/rcutiny.h | 6 +-----
> >  kernel/rcu/tiny.c       | 6 ++++++
> >  2 files changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> > index 0c6315c4a0fe..7eb66909ae1b 100644
> > --- a/include/linux/rcutiny.h
> > +++ b/include/linux/rcutiny.h
> > @@ -34,11 +34,7 @@ static inline void synchronize_rcu_expedited(void)
> >  	synchronize_rcu();
> >  }
> >  
> > -static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > -{
> > -	call_rcu(head, func);
> > -}
> > -
> > +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
> >  void rcu_qs(void);
> >  
> >  static inline void rcu_softirq_qs(void)
> > diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> > index aa897c3f2e92..508c82faa45c 100644
> > --- a/kernel/rcu/tiny.c
> > +++ b/kernel/rcu/tiny.c
> > @@ -177,6 +177,12 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  }
> >  EXPORT_SYMBOL_GPL(call_rcu);
> >  
> > +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > +{
> > +	call_rcu(head, func);
> > +}
> > +EXPORT_SYMBOL_GPL(kvfree_call_rcu);
> 
> This increases the size of Tiny RCU.  Plus in Tiny RCU, the overhead of
> synchronize_rcu() is exactly zero.  So why not make the single-argument
> kvfree_call_rcu() just unconditionally do synchronize_rcu() followed by
> kvfree() or whatever?  That should go just fine into the header file.
> 
Seems it does not go well if i do it in header file:

<snip>
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 0c6315c4a0fe..76b7ad053218 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -13,6 +13,7 @@
 #define __LINUX_TINY_H
 
 #include <asm/param.h> /* for HZ */
+#include <linux/mm.h>
 
 /* Never flag non-existent other CPUs! */
 static inline bool rcu_eqs_special_set(int cpu) { return false; }
@@ -36,7 +37,15 @@ static inline void synchronize_rcu_expedited(void)
 
 static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-       call_rcu(head, func);
+       if (head) {
+               call_rcu(head, func);
+               return;
+       }
+
+       // kvfree_rcu(one_arg) call.
+       might_sleep();
+       synchronize_rcu();
+       kvfree((void *) func);
 }
<snip> 

kvfree() is defined in <linux/mm.h> as extern void kvfree(const void *addr); 
If i just include <linux/mm.h> i get many errors related to "implicit declaration
of function" like:

<snip>
rcu_read_lock()
compound_mapcount_ptr()
rcu_assign_pointer()
...
<snip>

and many other messages like:

<snip>
warning: returning ‘int’ from a function with return type
error: unknown type name ‘vm_fault_t’; did you mean ‘pmdval_t’?
error: implicit declaration of function ‘RB_EMPTY_ROOT’
...
<snip>

Please see full log here: ftp://vps418301.ovh.net/incoming/include_mm_h_output.txt

I can fix it by adding the kvfree() declaration to the rcutiny.h also:
extern void kvfree(const void *addr);

what seems wired to me? Also it can be fixed if i move it to the tiny.c
so it will be aligned with the way how it is done for tree-RCU.

Any valuable proposals?

--
Vlad Rezki
