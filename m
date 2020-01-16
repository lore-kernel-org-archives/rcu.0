Return-Path: <SRS0=/SR9=3F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEC8C3F68F
	for <rcu@archiver.kernel.org>; Thu, 16 Jan 2020 18:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8772720663
	for <rcu@archiver.kernel.org>; Thu, 16 Jan 2020 18:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CC0D61/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388017AbgAPSVB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:21:01 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44933 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392514AbgAPR15 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Jan 2020 12:27:57 -0500
Received: by mail-lj1-f196.google.com with SMTP id u71so23522436lje.11;
        Thu, 16 Jan 2020 09:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KAfEq0Wia/8z+S4bm8ISIAkLRoETrLhDzNF3CD6LfUo=;
        b=CC0D61/ly4pXDeN66+tjpJvQRw+us91gGWNkXwaMXhXuk921z3PBxraiZLMjF1Lnuw
         IJNmch97bvt3ZuFpG0uSWWF0iu9WHRpYjrQFyYuxnzKXxBNM9b5WUa9KbQyPE93RYjsH
         Gy09E//nokyfyE0pzw0qdZvKQAHp+2Jbq9yy5Mtcsd5Q80cKvtIldbVKIv2WAJL2sJN0
         3f8Vc4bV6cbNFRTaFQh9FF6zuxV8lN0ahTI0ohvHyq58FYwBsNI9MQtrka9UX8OE3IMc
         BSZlKeXIU3LwyaKDhNhTTbs9I2Y06tGmUeki0TD7kOitLJlJLhfdcPX26NqpzwId3HDn
         Jp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KAfEq0Wia/8z+S4bm8ISIAkLRoETrLhDzNF3CD6LfUo=;
        b=VwDIRjUyD5TttKtMAdJDMQniiPDkeHGWStnDtzLoqi/X5OWMaVFlp7xzfnrWTtvHn/
         2d00CjW2FG2VSHWMWJU2ZLSeIcqH1gUQHE4ZFBzXDJztqK515s2cIDh8hSOJrv6wP1uW
         FjFdX/85YdOvtl/BHXkOExw5Q9kYg6OYKPJKw1ZxJkv6UiEiuoRqktVA7LLuSSBIS/AU
         hCcC3QeizcvPxjsEoo2NgWyMjIcaUzLTz/F2s4PzIsMoKCgsQ+A9znJhIjY1sPwL7u+D
         XWV48rweYqtdMTwxGooCS4vL35ve46D5Hk2JenYDarrXTPzWVubmVEchA7HE5Dc0N4pm
         UZgQ==
X-Gm-Message-State: APjAAAUqWU4cs5Ljes/X7BglECHQxWsvjNtKENNR1O8aR2UwK5/XSpzj
        XZ3JEMDQ5JEN4c2PnfBAcN0=
X-Google-Smtp-Source: APXvYqxRGtb4VF2mqDwJ9VTg1FQWW9gQRKo8nlEheXIkbVUsjfBcCWngFOnmK85dKlwinqOKXNcMyQ==
X-Received: by 2002:a2e:b4cb:: with SMTP id r11mr2989831ljm.68.1579195675798;
        Thu, 16 Jan 2020 09:27:55 -0800 (PST)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id z13sm11141629ljh.21.2020.01.16.09.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 09:27:55 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 16 Jan 2020 18:27:53 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: support kfree_bulk() interface in
 kfree_rcu()
Message-ID: <20200116172753.GB23524@pc636>
References: <20191231122241.5702-1-urezki@gmail.com>
 <20200116011410.GC246464@google.com>
 <20200116024126.GS2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116024126.GS2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 15, 2020 at 06:41:26PM -0800, Paul E. McKenney wrote:
> On Wed, Jan 15, 2020 at 08:14:10PM -0500, Joel Fernandes wrote:
> > On Tue, Dec 31, 2019 at 01:22:41PM +0100, Uladzislau Rezki (Sony) wrote:
> > > kfree_rcu() logic can be improved further by using kfree_bulk()
> > > interface along with "basic batching support" introduced earlier.
> > > 
> > > The are at least two advantages of using "bulk" interface:
> > > - in case of large number of kfree_rcu() requests kfree_bulk()
> > >   reduces the per-object overhead caused by calling kfree()
> > >   per-object.
> > > 
> > > - reduces the number of cache-misses due to "pointer chasing"
> > >   between objects which can be far spread between each other.
> > > 
> > > This approach defines a new kfree_rcu_bulk_data structure that
> > > stores pointers in an array with a specific size. Number of entries
> > > in that array depends on PAGE_SIZE making kfree_rcu_bulk_data
> > > structure to be exactly one page.
> > > 
> > > Since it deals with "block-chain" technique there is an extra
> > > need in dynamic allocation when a new block is required. Memory
> > > is allocated with GFP_NOWAIT | __GFP_NOWARN flags, i.e. that
> > > allows to skip direct reclaim under low memory condition to
> > > prevent stalling and fails silently under high memory pressure.
> > > 
> > > The "emergency path" gets maintained when a system is run out
> > > of memory. In that case objects are linked into regular list
> > > and that is it.
> > > 
> > > In order to evaluate it, the "rcuperf" was run to analyze how
> > > much memory is consumed and what is kfree_bulk() throughput.
> > > 
> > > Testing on the HiKey-960, arm64, 8xCPUs with below parameters:
> > > 
> > > CONFIG_SLAB=y
> > > kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1
> > > 
> > > 102898760401 ns, loops: 200000, batches: 5822, memory footprint: 158MB
> > > 89947009882  ns, loops: 200000, batches: 6715, memory footprint: 115MB
> > > 
> > > rcuperf shows approximately ~12% better throughput(Total time)
> > > in case of using "bulk" interface. The "drain logic" or its RCU
> > > callback does the work faster that leads to better throughput.
> > 
> > Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > (Vlad is going to post a v2 which fixes a debugobjects bug but that should
> > not have any impact on testing).
> 
> Very good!  Uladzislau, could you please add Joel's Tested-by in
> your next posting?
> 
I will add for sure, with the a V2 version. Also, i will update the
commit message by adding the results related to different slab cache
usage, i mean with Joel's recent patch.

Thank you.

--
Vlad Rezki
