Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C61C61DA4
	for <rcu@archiver.kernel.org>; Wed, 15 Mar 2023 22:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjCOWg7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Mar 2023 18:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjCOWgz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Mar 2023 18:36:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4C719F11;
        Wed, 15 Mar 2023 15:36:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48392B81F8C;
        Wed, 15 Mar 2023 22:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9128BC433EF;
        Wed, 15 Mar 2023 22:36:50 +0000 (UTC)
Date:   Wed, 15 Mar 2023 18:36:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 04/13] tracing: Rename kvfree_rcu() to
 kvfree_rcu_mightsleep()
Message-ID: <20230315183648.5164af0f@gandalf.local.home>
In-Reply-To: <ZAni8Q1NW9cWrvHJ@pc636>
References: <20230201150815.409582-1-urezki@gmail.com>
        <20230201150815.409582-5-urezki@gmail.com>
        <ZAni8Q1NW9cWrvHJ@pc636>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, 9 Mar 2023 14:45:21 +0100
Uladzislau Rezki <urezki@gmail.com> wrote:

> > The kvfree_rcu()'s single argument name is deprecated therefore
> > rename it to kvfree_rcu_mightsleep() variant. The goal is explicitly
> > underline that it is for sleepable contexts.
> > 
> > Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >  
> Could you please add you reviwed-by or Acked-by tags so we can bring
> our series with renaming for the next merge window?

I don't know. Perhaps we should just apply this patch and not worry about
sleeping and whatnot.

-- Steve

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 04f0fdae19a1..5de945a8f61d 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -76,6 +76,7 @@ static unsigned long osnoise_options	= OSN_DEFAULT_OPTIONS;
 struct osnoise_instance {
 	struct list_head	list;
 	struct trace_array	*tr;
+	struct rcu_head		rcu;
 };
 
 static struct list_head osnoise_instances;
@@ -159,7 +160,7 @@ static void osnoise_unregister_instance(struct trace_array *tr)
 	if (!found)
 		return;
 
-	kvfree_rcu(inst);
+	kvfree_rcu(inst, rcu);
 }
 
 /*
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 20d0c4a97633..ef5fafb40c76 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1172,7 +1172,7 @@ int trace_probe_remove_file(struct trace_probe *tp,
 		return -ENOENT;
 
 	list_del_rcu(&link->list);
-	kvfree_rcu(link);
+	kvfree_rcu(link, rcu);
 
 	if (list_empty(&tp->event->files))
 		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index ef8ed3b65d05..e6037752dcf0 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -256,6 +256,7 @@ struct trace_probe {
 struct event_file_link {
 	struct trace_event_file		*file;
 	struct list_head		list;
+	struct rcu_head			rcu;
 };
 
 static inline bool trace_probe_test_flag(struct trace_probe *tp,
