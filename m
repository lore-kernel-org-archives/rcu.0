Return-Path: <SRS0=Bbbz=DS=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C148C433DF
	for <rcu@archiver.kernel.org>; Sun, 11 Oct 2020 16:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8BC921655
	for <rcu@archiver.kernel.org>; Sun, 11 Oct 2020 16:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="cqEJYWuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388198AbgJKQft (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 11 Oct 2020 12:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387799AbgJKQft (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 11 Oct 2020 12:35:49 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E49C0613CE
        for <rcu@vger.kernel.org>; Sun, 11 Oct 2020 09:35:48 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k25so15279922ioh.7
        for <rcu@vger.kernel.org>; Sun, 11 Oct 2020 09:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dnAx+CMTWtccZoKo+7pJcGq4TFecPqxUqhMCcO/A1/I=;
        b=cqEJYWuwEM1wKqoR8MtOGNWkuTiZOeOubU7UCLM5TLYhOUrOBYY/iNWozxx7s7NZrp
         BYYhtvqaNJXJZmOM+6lJp+D+AftUShJPH1CDcl6kXqtJLV81D4Bcy/AAy3tY3/5TOZE6
         s2/MbUgnUWulLg+qD2aaRG9sEeP3AoIHhpgq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dnAx+CMTWtccZoKo+7pJcGq4TFecPqxUqhMCcO/A1/I=;
        b=dNBsSolicNVrdSpI1BhbTId5cBBO+LgXp2K2ZNiqouq9yPIfefjSnOObdjkPl9dj7b
         C3BOZowPOVnmbAQCsWbpQIok+OWL+t08lKXAUeFJMjwCz45bkg/rIkNxYbchP8VRSZDJ
         P5NIlI5+P/4QUbT458CBPXR25s7G6JX+d3MomRfARyyjGntCxe2I5XBCe4DdkayzhbuS
         d3i/esWq6wxxloYVKjFk+1TYq4+Ozd596FL6jIzC3z8IP9zud+QQmxiQRYxLpAPq0pLi
         02Amb30rsue4IVsoBeUWMTH148liTfLT72Me+8w1Oab+XpdVXATeQeq5V/j3HlPxzvS0
         W1kA==
X-Gm-Message-State: AOAM531j4Zy0kqwEd0XD252riT8AoehCRXpP2e0KRAAurhcsi5Rq2Ptr
        2tsSNK6szcrBA8ui2hBNYv7MatZU98y5DO1+gmcmn9CFmoTClA==
X-Google-Smtp-Source: ABdhPJyDKLD3OzLZr0zfGpxZPtYDNRDMeu31N4+Ga/xKGYNkKAUSfyMCi88QYCSgSybenInsZH9W4377NNtfLIdnYNo=
X-Received: by 2002:a02:110a:: with SMTP id 10mr16886097jaf.23.1602434148107;
 Sun, 11 Oct 2020 09:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200923152211.2403352-1-joel@joelfernandes.org>
 <20200923152211.2403352-2-joel@joelfernandes.org> <20201009231409.GA120772@lothringen>
In-Reply-To: <20201009231409.GA120772@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 11 Oct 2020 09:35:37 -0700
Message-ID: <CAEXW_YQPFM81EXi+7c6ed9b2ULw4YmtfGzmT1GKUGVu5v6CyGg@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] rcu/tree: Make rcu_do_batch count how many
 callbacks were executed
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 9, 2020 at 4:14 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Wed, Sep 23, 2020 at 11:22:08AM -0400, Joel Fernandes (Google) wrote:
> > Currently, rcu_do_batch() depends on the unsegmented callback list's len field
> > to know how many CBs are executed. This fields counts down from 0 as CBs are
> > dequeued.  It is possible that all CBs could not be run because of reaching
> > limits in which case the remaining unexecuted callbacks are requeued in the
> > CPU's segcblist.
> >
> > The number of callbacks that were not requeued are then the negative count (how
> > many CBs were run) stored in the rcl->len which has been counting down on every
> > dequeue. This negative count is then added to the per-cpu segmented callback
> > list's to correct its count.
> >
> > Such a design works against future efforts to track the length of each segment
> > of the segmented callback list. The reason is because
> > rcu_segcblist_extract_done_cbs() will be populating the unsegmented callback
> > list's length field (rcl->len) during extraction.
> > Also, the design of counting down from 0 is confusing and error-prone IMHO.
>
> Right :)

:)

> > This commit therefore explicitly counts have many callbacks were executed in
>
> s/have/how
>
> > rcu_do_batch() itself, and uses that to update the per-CPU segcb list's ->len
> > field, without relying on the negativity of rcl->len.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks! Paul would be Ok to make the minor fixup s/have/how/ that
Frederic pointed?

- Joel
(Due to COVID issues at home, I'm intermittently working so advance
apologies for slow replies.)
