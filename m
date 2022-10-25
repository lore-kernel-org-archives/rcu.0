Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9F8FA3742
	for <rcu@archiver.kernel.org>; Tue, 25 Oct 2022 04:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJYEUF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Oct 2022 00:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiJYEUE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Oct 2022 00:20:04 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8492443AD0
        for <rcu@vger.kernel.org>; Mon, 24 Oct 2022 21:20:01 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id ml12so6825875qvb.0
        for <rcu@vger.kernel.org>; Mon, 24 Oct 2022 21:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Uw0upS0qH/Dh6yWZ0csr+I4nuaoeQNCZlNeulnctJs=;
        b=RDzgd4ItPvImIQboV1VWvznNQIPTNeHho7E1eUhEFK83/jL7VU+OhV2spCBPifZGX6
         PKc5Ar7wtvabBZ4tfMi3kjCHPA7I/8c1GxIk1R0awna963WmhJKRuVtH2oArQ47el8+f
         R1H2JnHR2DD04eYuSwLeiPP6dzGAhYXBZ0OtNQCxmAErqnDgXy60U86Vy8wwyLw/3qSp
         9da/dhvntOdFlWu8r905Lq9ukv4swNZ9Lbb5WOf9LYL8iLWRHLVDzgNzmYLJ7JQI+Ac0
         tL4y3WhMjjetRUKbEbanyYPxK7cA2RraGXSx1x+2LkemAZWs/MFX7313o/Os7hLOJX9e
         aAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Uw0upS0qH/Dh6yWZ0csr+I4nuaoeQNCZlNeulnctJs=;
        b=dSo23a4K6iYUR6bNAyFXPE1fbxTZE1EK7twPDkzKWZiWpevf1djnJhoryMsUMclnvn
         nvQKlEGFjClnVBFEcyi0Gj6xEETH3vPk0B277fQPeUmRsqDrazn8m0r3KH/8NtoQb1lc
         LKXdpeUEvt9rGudzqH1SNcWLWuEawslYHQ2OaairOwN+sHkLdsPPqw3GDjH+t/AvwQmO
         UD9mw3V8xSiUzBuYt0CcxPtTJ0/NS3mxvxqiluJ0qRtSgcO4p/hBR3SHcxsYrlx2KpcP
         K8pxNgAAkEDhY0ijDaHY2g70/uCpcdV5adlbVo5d8yoLlWTYDr0ZhlaSvCWT/DLl35SY
         USWQ==
X-Gm-Message-State: ACrzQf10QV1U20/YEONotI8T4sU5TKApvg65IEmhUl7ccAoZRzco4L4M
        IXQgmltLCtWJrEXpYpeEZvRp/g==
X-Google-Smtp-Source: AMsMyM4f6ujxPgWdNjBGcU8lOd4F2/NW5zXc74HddwAQGUoyu7EeaL4Av/QPlNNPkt2CB+eZjFq8Cg==
X-Received: by 2002:a0c:f5ca:0:b0:4bb:6f16:c0ca with SMTP id q10-20020a0cf5ca000000b004bb6f16c0camr7292716qvm.111.1666671600184;
        Mon, 24 Oct 2022 21:20:00 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x14-20020a05620a448e00b006ed30a8fb21sm1345417qkp.76.2022.10.24.21.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 21:19:59 -0700 (PDT)
Date:   Mon, 24 Oct 2022 21:19:57 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Laight <David.Laight@aculab.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
In-Reply-To: <7dddca4c-bc36-2cf0-de1c-a770bef9e1b7@suse.cz>
Message-ID: <904cc831-eb16-b1e5-10e5-9e7a171ef83@google.com>
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com> <YzPgTtFzpKEfwPbK@hyeyoo> <YzRQvoVsnJzsauwb@google.com> <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz> <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com> <de71b83a-c82c-4785-ef5a-3db4f17bbc8d@suse.cz>
 <bcecece-f7ce-221d-1674-da3d5ab3fef@google.com> <YzkmErHFyYW3awRn@hyeyoo> <YzsVM8eToHUeTP75@casper.infradead.org> <7dddca4c-bc36-2cf0-de1c-a770bef9e1b7@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, 24 Oct 2022, Vlastimil Babka wrote:
> On 10/3/22 19:00, Matthew Wilcox wrote:
> > On Sun, Oct 02, 2022 at 02:48:02PM +0900, Hyeonggon Yoo wrote:
> >> Just one more thing, rcu_leak_callback too. RCU seem to use it
> >> internally to catch double call_rcu().
> >> 
> >> And some suggestions:
> >> - what about adding runtime WARN() on slab init code to catch
> >>   unexpected arch/toolchain issues?
> >> - instead of 4, we may use macro definition? like (PAGE_MAPPING_FLAGS + 1)?
> > 
> > I think the real problem here is that isolate_movable_page() is
> > insufficiently paranoid.  Looking at the gyrations that GUP and the
> > page cache do to convince themselves that the page they got really is
> > the page they wanted, there are a few missing pieces (eg checking that
> > you actually got a refcount on _this_ page and not some random other
> > page you were temporarily part of a compound page with).
> > 
> > This patch does three things:
> > 
> >  - Turns one of the comments into English.  There are some others
> >    which I'm still scratching my head over.
> >  - Uses a folio to help distinguish which operations are being done
> >    to the head vs the specific page (this is somewhat an abuse of the
> >    folio concept, but it's acceptable)
> >  - Add the aforementioned check that we're actually operating on the
> >    page that we think we want to be.
> >  - Add a check that the folio isn't secretly a slab.
> > 
> > We could put the slab check in PageMapping and call it after taking
> > the folio lock, but that seems pointless.  It's the acquisition of
> > the refcount which stabilises the slab flag, not holding the lock.
> > 
> 
> I would like to have a working safe version in -next, even if we are able
> simplify it later thanks to frozen refcounts. I've made a formal patch of
> yours, but I'm still convinced the slab check needs to be more paranoid so
> it can't observe a false positive __folio_test_movable() while missing the
> folio_test_slab(), hence I added the barriers as in my previous attempt [1].
> Does that work for you and can I add your S-o-b?
> 
> [1] https://lore.kernel.org/all/aec59f53-0e53-1736-5932-25407125d4d4@suse.cz/

Ignore me, don't let me distract if you're happy with Matthew's patch
(I know little of PageMovable, and I haven't tried to understand it);
but it did look to me more like 6.2 material, and I was surprised that
you dropped the simple align(4) approach for 6.1.

Because of Hyeonggon's rcu_leak_callback() observation?  That was a
good catch, but turned out to be irrelevant, because it was only for
an RCU debugging option, which would never be set up on a struct page
(well, maybe it would in a dynamically-allocated-struct-page future).

Hugh
