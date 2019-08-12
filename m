Return-Path: <SRS0=P5Uu=WI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6782C31E40
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 20:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BEC20684
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 20:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Xe1HCglz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfHLUmI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:42:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39021 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHLUmI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 12 Aug 2019 16:42:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id z3so1502958pln.6
        for <rcu@vger.kernel.org>; Mon, 12 Aug 2019 13:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HB3fJfLK4PnVLPAunkiBcGzstN0wP/veN+x35xEeTW4=;
        b=Xe1HCglzqQ/jt0qNR/aglTK1b4gWyuldTqcJGOCn2p8MviY8GjAePqFA8W6qXYNWwh
         2cixQe7Xk+CMRlinmlShEIITwIG+/yKYjpZ4tXo+xdxjqX6r2AXuhjY1AXgfF/+pPLpt
         3H4FA7FbPHHMEjZxSLeUZCOeIzQH+QoS9hGTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HB3fJfLK4PnVLPAunkiBcGzstN0wP/veN+x35xEeTW4=;
        b=F0+CP3dsYywK3O1PPiI+QqJX3Az2mbtZciR631RZcgxFtIWfH0GXuq14+kFwqWMBAH
         GZ7nefgUUQZHbEaRhEaqhD8xZMMdlj20QzB09Xlln3TLDB/PaGhufD5Bg04wswMbfMU5
         URqHJ7U6B8YQqZAQ2N+Ze4H+iQ84WE9LJN2K3uyGbeXu3BLGABDow6wFe4F0hXx9k7n8
         AC5+YE9MnnLIXkDCrocl7dlKuMQ7598oYKY5yv4aSeBRUiHPEu+k0CphqSNgvAiKRFbR
         6HqA3S+r7Notzqop1NH6zTaQxmrdOJ5fS+XyvPN57GOXmQBPSk+pCxxBFMMkaYUws/X3
         qtfg==
X-Gm-Message-State: APjAAAV72HO/wwAikotZhrQxwXqM0BBDLJISSW0yyotbsl0pBmu78oqP
        uBf7sgfyAZBx3VlMi9ZTvclNvw==
X-Google-Smtp-Source: APXvYqzPYpjVmv8OPuJ7/zhwmE1fv9Mj7f2m91Oz+OJyXmJx2LhgvftlfMirHjQRBKJSR4vGQbrjbw==
X-Received: by 2002:a17:902:1004:: with SMTP id b4mr23932384pla.340.1565642527441;
        Mon, 12 Aug 2019 13:42:07 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a4sm2991210pfi.55.2019.08.12.13.42.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 13:42:06 -0700 (PDT)
Date:   Mon, 12 Aug 2019 16:42:05 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/3] doc: Update documentation about
 list_for_each_entry_rcu (v1)
Message-ID: <20190812204205.GA48751@google.com>
References: <20190811221111.99401-1-joel@joelfernandes.org>
 <20190811221111.99401-2-joel@joelfernandes.org>
 <20190812202241.GP28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812202241.GP28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 12, 2019 at 01:22:41PM -0700, Paul E. McKenney wrote:
> On Sun, Aug 11, 2019 at 06:11:10PM -0400, Joel Fernandes (Google) wrote:
> > This patch updates the documentation with information about
> > usage of lockdep with list_for_each_entry_rcu().
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Thank you!!!
> 
> I queued this for v5.5 with the following wordsmithing.  Please check
> to make sure that I didn't mess anything up.

Yes, this looks great to me. thanks!

Also, I will send out the other drivers/core patch of this series in a bit
with Steve's suggestion.

 - Joel

[snip]
