Return-Path: <SRS0=3CeA=5U=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8107FC2BA17
	for <rcu@archiver.kernel.org>; Sat,  4 Apr 2020 19:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7F6206F5
	for <rcu@archiver.kernel.org>; Sat,  4 Apr 2020 19:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJWfSqmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgDDTJe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 4 Apr 2020 15:09:34 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44095 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgDDTJe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 4 Apr 2020 15:09:34 -0400
Received: by mail-lf1-f65.google.com with SMTP id 131so8494104lfh.11;
        Sat, 04 Apr 2020 12:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cv6xnrTRODwtxm6ik3+0p7UKLU5YsK0bKozKaU8wMGI=;
        b=uJWfSqmw8KaFiG+RqkyvU3MBFnV5Y28SWNdjoS40IUGdLjeHGGux/SUmElr/IYFHzH
         Reo0Q826zgUEd/QeyauIhNywQaxhJg+ziPWu3TqIVzL9OSnkRaaCY56cMCVNU0+PV2On
         /XOe4w2v68IEeD3hCZUSHaC3UbVgwm6KYvZILxad/IDJWHgZC/wMoVNv14kxfDWwSRTQ
         hAcikTZ/roD40twXYOpz6lg26XxSOIZ/OXy7pofxdheW7TjFyrXxMiqUxycE8O9t3oeP
         uT7EXrQuJyvV+SY1mH3D7m1H55CIFMb0TXd5spkIvCGq465oAmnkK0FLTJXb93kjUAp5
         Oh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cv6xnrTRODwtxm6ik3+0p7UKLU5YsK0bKozKaU8wMGI=;
        b=Gc+YfyzS4kLMU7+QJDTYlG2dN6LLHH2WNEYwVYzb+V9MOu/tsEcZtOCxlgX310cQKr
         C+HZZ39S8B6hqIWv50XZRmU0FZ/rAIp1Bf1JKjh509uJh2tD7o6+JRfFWbrP2jpg02hE
         nlXJ0Ya00RjrmO92dphmZYm4GKeoo2P2CH0Ny5rIq4d849IU1SPvM8i/OlQFjaVhIHAm
         QCLpD92ZGnF5ZnAb3rYl4My/U9t/wT+xHCJg0MgGpKSsx4zv0Qr/mGzEhH5TkJ+qqHTO
         5wFLOxM4Oz/kI5HjYFqNfzhBC3lril2YSxFgbErt3R+yuKST7XeDBplSMeVKrJxJrsp9
         jyaA==
X-Gm-Message-State: AGi0PuYP5nuIlExT5ZYpzj23NPAraae4B/kKZ2aKUy06jgPK60Uawwx+
        s+mLZDWxA13FZXxGz7KUBA0=
X-Google-Smtp-Source: APiQypK7V4Nug/szoSqA+5cqvVc107goHH4D52ORHpCrSyk5/IgAWm9FvmdTRTC087ZhYY69pXrwnQ==
X-Received: by 2002:ac2:50cf:: with SMTP id h15mr8951798lfm.127.1586027371915;
        Sat, 04 Apr 2020 12:09:31 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id c4sm4056408ljd.30.2020.04.04.12.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 12:09:31 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sat, 4 Apr 2020 21:09:29 +0200
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: add emergency pool for headless case
Message-ID: <20200404190929.GC424@pc636>
References: <20200403173051.4081-1-urezki@gmail.com>
 <20200403181655.GR21484@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403181655.GR21484@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Matthew.

> On Fri, Apr 03, 2020 at 07:30:51PM +0200, Uladzislau Rezki (Sony) wrote:
> > @@ -2877,6 +2885,12 @@ struct kfree_rcu_cpu {
> >  	bool initialized;
> >  	// Number of objects for which GP not started
> >  	int count;
> > +
> > +	/*
> > +	 * Reserved emergency pool for headless variant.
> > +	 */
> > +	int nr_emergency;
> > +	void **emergency;
> 
> This is a pretty expensive way to maintain an emergency pool.
> 
Well. I do not see what is expansive there, really. But i see
some drawbacks i would like to fix. First of all get rid of

<snip>
    krcp->emergency = kmalloc_array(rcu_nr_emergency_objs,
        sizeof(void *), GFP_NOWAIT);
<snip>

and second one, as you pointed below to use list instead of
an array. There is some advantages, first is no need in array
bound check, second, in case of list we can dynamically control
its length via exposed sysfs attribute.

> Try something like this ...
> 
> struct emergency_pool_object {
> 	union {
> 		struct whatever foo;
> 		struct {
> 			int remaining;
> 			void *next;
> 		};
> 	};
> };
> 
> struct kfree_rcu_cpu {
> 	...
> 	struct emergency_pool_object *epo;
> };
> 
> struct whatever *get_emergency_object(struct kfree_rcu_cpu *krc)
> {
> 	struct emergency_pool_object *epo = krc->epo;
> 	if (epo)
> 		krc->epo = epo->next;
> 	return &epo->foo;
> }
> 
> void alloc_emergency_objects(struct kfree_rcu_cpu *krc, int n)
> {
> 	int i = 0;
> 
> 	if (krc->epo)
> 		i = krc->epo->remaining;
> 
> 	while (++i < n) {
> 		struct emergency_pool_object *epo = kmalloc(sizeof(epo), GFP);
> 		epo->remaining = i;
> 		epo->next = krc->epo;
> 		krc->epo = epo;
> 	}
> }
> 
I will upload v2. I just stash objects in the list. Something like:

<snip>
@@ -2877,6 +2888,18 @@ struct kfree_rcu_cpu {
        bool initialized;
        // Number of objects for which GP not started
        int count;
+
+       /*
+        * Reserved emergency objects for headless variant.
+        * The objects are queued into the lock-less list,
+        * the length of the list is limited therefore we
+        * also have a counter.
+        *
+        * Actually we have the room for embedding a counter
+        * into our cached object, but let's keep it simple.
+        */
+       int nr_objs_elist;
+       struct llist_head elist;
 };
...
+static inline unsigned long *
+get_emergency_object(struct kfree_rcu_cpu *krcp)
+{
+       if (!krcp->nr_objs_elist)
+               return NULL;
+
+       krcp->nr_objs_elist--;
+       return (unsigned long *)
+               llist_del_first(&krcp->elist);
+}
+
+static inline bool
+put_emergency_object(struct kfree_rcu_cpu *krcp,
+       unsigned long *obj)
+{
+       /* Check the limit. */
+       if (krcp->nr_objs_elist >= rcu_nr_emergency_objs)
+               return false;
+
+       llist_add((struct llist_node *) obj, &krcp->elist);
+       krcp->nr_objs_elist++;
+       return true;
+}
<snip>

Thanks for your comments!

--
Vlad Rezki
